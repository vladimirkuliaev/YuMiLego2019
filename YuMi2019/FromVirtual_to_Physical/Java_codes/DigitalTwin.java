package mygame;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.net.UnknownHostException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import com.jme3.asset.AssetManager;
import com.jme3.math.FastMath;
import com.jme3.math.Vector3f;
import com.jme3.scene.Node;
import com.prosysopc.ua.ServiceException;
import com.prosysopc.ua.client.AddressSpaceException;
import com.prosysopc.ua.nodes.UaNode;
import com.prosysopc.ua.nodes.UaReference;

import aalto.types.DigitalProductDescription.CadPartType;
import aalto.types.DigitalProductDescription.CoordinateType;
import aalto.types.DigitalProductDescription.DigitalPartType;
import aalto.types.DigitalProductDescription.RectangleLegoType;
import aalto.types.DigitalProductDescription.SquareLegoType;
import opcua.Client;

/**
 *
 * @author ssierla
 */
public class DigitalTwin {
    private int legoNum = 1; // for debugging

    public Node node = new Node();
    private HashMap<String, DigitalPart> map = new HashMap<String, DigitalPart>();
    private ArrayList connections = new ArrayList();
    private int connectionsSize = 0;
    int count = 0;
    private RobotArm assemblyArm;
    private AssemblyStation assemblyStation;
    private float assemblySurfaceHeight;
    private MobileRobot mobileRobot;

    ArrayList<DigitalPart> legos = new ArrayList(100);
    ArrayList<DigitalPart> unassembledLegos = new ArrayList(100);
    private DigitalPart lego;
    private DigitalPart twinLego;
    private Trajectory trajectory;
    float maxHeight = 4;
    int legosSize;
    float rot;
    float rotPrev = 0;
    int rotCounter = 0;
    boolean trajectoryMotion = false;
    boolean bottomReady = false;
    boolean exploringTrajectory; // with digital twin
    boolean rotationMotion; // as opposed to straight line motion

    public static boolean connectingUpward = false;
    boolean gotoLego = false;
    boolean assemblyInProgress = false;
    Vector3f trajectoryPoint;
    // int approachAttempt = 0;
    private boolean collisionDetection = false;
    private boolean virtualAssemblyComplete = false;
    private boolean physicalAssembly = false;
    private boolean waitingForLego = false;
    private boolean initialRotation = false;
    private Cell cell;
    private float biggestX = Main.dim * 10; // dimension of the DigitalPart - default is for legos
    private float biggestZ = Main.dim * 10;

    public void initPhysicalAssembly() {
	System.exit(0);
	Main.helloText.setText("Physical assembly");
	for (int i = 0; i < legosSize; i++) {
	    legos.get(i).assembled = false;
	    legos.get(i).state = LegoState.ToBeFetched;
	    node.detachChild(legos.get(i).node);
	    if (legos.get(i).northSouthOrientation()) {
		legos.get(i).node.rotate(0, -1 * FastMath.HALF_PI, 0);
	    }
	    legos.get(i).translate(legos.get(i).startLocation);
	}
	physicalAssembly = true;
	bottomReady = false;
	// Main.assemblyArm.rotateBack();
	assemblyArm.initRotate(this);
	connectingUpward = false;

	// RobotArm.step = 0.02f;
	// RobotArm.maxRotationStep = 300;
	cell.attachNodeToRoot(true);
	cell.getMobileRobot().start = true;
    }

    public void receivePhysicalLego(String id) {
	// System.out.println("Received " + id);
	// RobotArm.step = 0.1f;
	for (int i = 0; i < legosSize; i++) {
	    if (legos.get(i).id.equals(id)) {
		legos.get(i).state = LegoState.AtAssembly;
		node.attachChild(legos.get(i).node);
		legos.get(i).node.rotate(-1 * legos.get(i).orientation.getX(), -1 * legos.get(i).orientation.getY(),
			-1 * legos.get(i).orientation.getZ());
		// legos.get(i).translate(legos.get(i).startLocation);
	    }
	    /*
	     * if(legos.get(i).northSouthOrientation()) { legos.get(i).node.rotate(0,
	     * -1*FastMath.HALF_PI, 0); }
	     */

	}
    }

    private boolean connectUpward(DigitalPart lego) {
	if (!lego.isLego()) {
	    return false;
	}
	for (int i = 0; i < connectionsSize; i++) {
	    LegoConnection connection = (LegoConnection) connections.get(i);

	    // if"lego" is to be connected to the bottom of an assembled lego return true
	    if (lego.equals(connection.lego2) && connection.lego1.assembled) {
		String cp1 = connection.connectionPoint1;
		if ((cp1.equals("bottom") || cp1.equals("bottomA") || cp1.equals("bottomB") || cp1.equals("bottomC"))) {
		    return true;
		}
	    }

	    if (lego.equals(connection.lego1) && connection.lego2.assembled) {
		String cp2 = connection.connectionPoint2;
		if ((cp2.equals("bottom") || cp2.equals("bottomA") || cp2.equals("bottomB") || cp2.equals("bottomC"))) {
		    return true;
		}
	    }
	}
	return false;
    }

    public DigitalTwin(List<DigitalPartType> parts, Set<UaReference> conns, AssetManager assetManager, Cell c,
	    Client uaClient) throws ServiceException, AddressSpaceException {
	cell = c;
	mobileRobot = c.getMobileRobot();
	assemblyStation = cell.requestAssemblyStation();
	assemblyArm = assemblyStation.assemblyArm;
	assemblySurfaceHeight = assemblyStation.getSurfaceHeight();

	/*
	 * Iterating through all the parts and creating a corresponding 3D-object.
	 */
	boolean firstPart = true;
	DigitalPart p = null;
	for (DigitalPartType part : parts) {
	    if (uaClient.compareType(part, aalto.types.DigitalProductDescription.Ids.SquareLegoType)) {
		SquareLegoType square = (SquareLegoType) part;
		String name = square.getDisplayName().getText();
		String color = square.getColor();
		p = new Square(name, color, assetManager);
	    } else if (uaClient.compareType(part, aalto.types.DigitalProductDescription.Ids.RectangleLegoType)) {
		RectangleLegoType rect = (RectangleLegoType) part;
		String name = rect.getDisplayName().getText();
		String color = rect.getColor();
		String orient = rect.getOrientation();
		p = new Rectangle(name, color, orient, assetManager);
	    } else {
		CadPartType cad = (CadPartType) part;
		String name = cad.getDisplayName().getText();
		String color = cad.getColor();
		String orient = cad.getOrientation();
		String typeName = cad.getTypeDefinition().getDisplayName().getText();
		String path = cad.getPathToModel();
		p = new CADpart(typeName, name, color, assetManager, orient, path);
		if ((2 * p.getXextent()) > biggestX) {
		    biggestX = p.getXextent() * 2 + Main.dim;
		}
		if ((p.getZextent() * 2) > biggestZ) {
		    biggestZ = p.getZextent() * 2 + Main.dim;
		}
	    }
	    p.twin = this;
	    map.put(p.id, p);
	    if (firstPart) {
		firstPart = false;
		p.translateTarget(new Vector3f(-7, 0, -10));
		p.assembled = true;
		p.assemblyLocation = p.targetLocation;
	    }
	    node.attachChild(p.node);
	    legos.add(p);
	}

	/*
	 * This is here only for CAD-parts to work properly. It gets all cadTypes from
	 * the address space and calls add3dparam once for each connectionPoint of each
	 * type.
	 *
	 * This is run every time the constructor is called and it adds all cadTypes
	 * that are in the address space even if the digitalTwin has no cad parts.
	 */
	for (UaNode type : uaClient.getCadTypes()) {
	    String typename = type.getDisplayName().getText();
	    for (CoordinateType connectionPoint : uaClient.getConnectionPoints(type)) {
		String name = connectionPoint.getDisplayName().getText();
		String coordinates = connectionPoint.getX() + "," + connectionPoint.getY() + ","
			+ connectionPoint.getZ();
		CADpart.add3dParam(typename + name, coordinates);
	    }
	}

	/*
	 * Iterating through all OPC UA references between connectionPoint and creating
	 * corresponding Connection-object.
	 */
	for (UaReference conn : conns) {
	    UaNode connectionPoint1 = conn.getSourceNode();
	    UaNode connectionPoint2 = conn.getTargetNode();
	    UaNode part1 = uaClient.getPart(connectionPoint1);
	    UaNode part2 = uaClient.getPart(connectionPoint2);
	    LegoConnection connection = new LegoConnection();
	    connection.lego1 = map.get(part1.getDisplayName().getText());
	    connection.lego2 = map.get(part2.getDisplayName().getText());
	    connection.connectionPoint1 = connectionPoint1.getDisplayName().getText();
	    connection.connectionPoint2 = connectionPoint2.getDisplayName().getText();
	    connections.add(connection);
	    connectionsSize++;
	}

	assemblyStation.setSlotSpacing(biggestX, biggestZ);

	Iterator it = map.entrySet().iterator();
	DigitalPart lego;
	int index = 0;
	while (it.hasNext()) {
	    HashMap.Entry pair = (HashMap.Entry) it.next();
	    lego = (DigitalPart) pair.getValue();
	    // lego.startLocation = new Vector3f(6.0f - 12.0f * (index%2),
	    // assemblySurfaceHeight + Main.dim, -4.0f - 2.0f * (index/2));
	    lego.startLocation = assemblyStation.slotPosition(index, lego.getYextent());
	    lego.translate(lego.startLocation);
	    // it.remove(); // avoids a ConcurrentModificationException
	    index++;
	}

	// Now go through the lego connections and translate each lego into the correct
	// place
	// We iterate until we find an unconnected connection involving one lego that
	// was already assembled
	// With this tactic, we have to iterate over the connections several times until
	// everything is connected
	boolean allConnected = false;
	while (!allConnected) {
	    allConnected = true;
	    Iterator<LegoConnection> itr = connections.iterator();
	    while (itr.hasNext()) {
		Vector3f connectionPoint;

		LegoConnection connection = itr.next();
		if (connection.connected) {
		    continue;
		}
		allConnected = false;
		if (connection.lego1.assembled && !connection.lego2.assembled) {
		    connectionPoint = connection.lego1.getConnectionPoint(connection.connectionPoint1);
		    // System.out.println(connectionPoint.toString());
		    // Now translate lego2 to the connectionPoint of lego1
		    connection.lego2.translateTarget(connectionPoint);
		    // System.out.println(connection.lego2.targetLocation.toString());
		    // Now translate lego2 so that its appropriate connectionPoint is being
		    // connected
		    connection.lego2.translateConnectionPoint(connection.connectionPoint2);
		    // System.out.println(connection.lego2.targetLocation.toString());
		    connection.lego2.assembled = true;
		    connection.lego2.assemblyLocation = connection.lego2.targetLocation;
		    connection.connected = true;
		}

		if (!connection.lego1.assembled && connection.lego2.assembled) {
		    connectionPoint = connection.lego2.getConnectionPoint(connection.connectionPoint2);
		    // Now translate lego1 to the connectionPoint of lego2
		    connection.lego1.translateTarget(connectionPoint);
		    // Now translate lego1 so that its appropriate connectionPoint is being
		    // connected
		    connection.lego1.translateConnectionPoint(connection.connectionPoint1);
		    connection.lego1.assembled = true;
		    connection.lego1.assemblyLocation = connection.lego1.targetLocation;
		    connection.connected = true;
		}
	    }
	}
	legosSize = legos.size();
	lego = legos.get(0);
	lego.moving = true;

	float bottom = 1000;
	for (int i = 0; i < legosSize; i++) {
	    legos.get(i).assembled = false;
	    if (legos.get(i).assemblyLocation.getY() < bottom) {
		bottom = legos.get(i).assemblyLocation.getY();
	    }
	}
	for (int i = 0; i < legosSize; i++) {
	    if (legos.get(i).assemblyLocation.getY() < bottom + 0.001f) {
		legos.get(i).bottomLayer = true;
		mobileRobot.addToQueue(legos.get(i));
	    }
	}
	float distanceToFloor = bottom - assemblySurfaceHeight - lego.getYextent(); // 3*Main.dim;
	for (int i = 0; i < legosSize; i++) {
	    legos.get(i).assemblyLocation.setY(legos.get(i).assemblyLocation.getY() - distanceToFloor);
	}
    }

    public DigitalTwin(String fileName, AssetManager assetManager, Cell c) {
	cell = c;
	mobileRobot = c.getMobileRobot();
	assemblyStation = cell.requestAssemblyStation();
	assemblyArm = assemblyStation.assemblyArm;
	assemblySurfaceHeight = assemblyStation.getSurfaceHeight();

	try {
	    BufferedReader reader = new BufferedReader(new FileReader(fileName));
	    int lineCounter = 0;
	    String line;

	    boolean firstPart = true;
//uncomment
	    String start = new String("Start");
	    // socket.InitializeSocket();
	    // socket.sendCommand(start);

	    while ((line = reader.readLine()) != null) {
		String words[] = line.split(" ");

		if (words[0].equals("//")) {
		    continue;
		}

		if (words[0].equals("create")) {
		    if (words[1].equals("square") || words[1].equals("SquareLego")) {
			Square s = new Square(words[2], words[3], assetManager);
			s.twin = this;
			map.put(s.id, s);
			if (firstPart) {
			    firstPart = false;
			    s.translateTarget(new Vector3f(-7, 0, -10));
			    s.assembled = true;
			    s.assemblyLocation = s.targetLocation;
			}
			node.attachChild(s.node);
			legos.add(s);
		    } else if (words[1].equals("rectangle") || words[1].equals("RectangleLego")) {
			Rectangle r = new Rectangle(words[2], words[3], words[4], assetManager);
			r.twin = this;
			map.put(r.id, r);
			if (firstPart) {
			    firstPart = false;
			    r.translateTarget(new Vector3f(-7, 0, -10));
			    r.assembled = true;
			    r.assemblyLocation = r.targetLocation;
			}
			node.attachChild(r.node);
			legos.add(r);
		    } else { // we assume it is a CADpart
			CADpart p = new CADpart(words[1], words[2], words[3], assetManager, words[4]);
			p.twin = this;
			map.put(p.id, p);
			if (firstPart) {
			    firstPart = false;
			    p.translateTarget(new Vector3f(-7, 0, -10));
			    p.assembled = true;
			    p.assemblyLocation = p.targetLocation;
			}
			node.attachChild(p.node);
			legos.add(p);
			if ((2 * p.getXextent()) > biggestX) {
			    biggestX = p.getXextent() * 2 + Main.dim;
			}
			if ((p.getZextent() * 2) > biggestZ) {
			    biggestZ = p.getZextent() * 2 + Main.dim;
			}
		    }

		    /*
		     * if (words[1].equals("faceplateback")|| words[1].equals("FaceplateBack")) {
		     * FaceplateBack f = new FaceplateBack(words[2], assetManager); f.twin = this;
		     * map.put(f.id,f); if (firstPart) { firstPart = false; f.translateTarget(new
		     * Vector3f(-7,0,-10)); f.assembled = true; f.assemblyLocation =
		     * f.targetLocation; } node.attachChild(f.node); legos.add(f); } if
		     * (words[1].equals("boltangular")|| words[1].equals("BoltAngular")) {
		     * BoltAngular b = new BoltAngular(words[2], assetManager); b.twin = this;
		     * map.put(b.id,b); if (firstPart) { firstPart = false; b.translateTarget(new
		     * Vector3f(-7,0,-10)); b.assembled = true; b.assemblyLocation =
		     * b.targetLocation; } node.attachChild(b.node); legos.add(b); } if
		     * (words[1].equals("bolt")|| words[1].equals("Bolt")) { Bolt b = new
		     * Bolt(words[2], assetManager); b.twin = this; map.put(b.id,b); if (firstPart)
		     * { firstPart = false; b.translateTarget(new Vector3f(-7,0,-10)); b.assembled =
		     * true; b.assemblyLocation = b.targetLocation; } node.attachChild(b.node);
		     * legos.add(b); } if (words[1].equals("shaft")|| words[1].equals("Shaft")) {
		     * Shaft s = new Shaft(words[2], assetManager); s.twin = this; map.put(s.id,s);
		     * if (firstPart) { firstPart = false; s.translateTarget(new
		     * Vector3f(-7,0,-10)); s.assembled = true; s.assemblyLocation =
		     * s.targetLocation; } node.attachChild(s.node); legos.add(s); } if
		     * (words[1].equals("pendulum")|| words[1].equals("Pendulum")) { Pendulum p =
		     * new Pendulum(words[2], assetManager, words[3], words[4]); p.twin = this;
		     * map.put(p.id,p); if (firstPart) { firstPart = false; p.translateTarget(new
		     * Vector3f(-7,0,-10)); p.assembled = true; p.assemblyLocation =
		     * p.targetLocation; } node.attachChild(p.node); legos.add(p); }
		     */
		}

		if (words[0].equals("param")) {
		    CADpart.add3dParam(words[1] + words[2], words[3]);
		}

		if (words[0].equals("connect")) {
		    LegoConnection connection = new LegoConnection();
		    connection.lego1 = map.get(words[1]);
		    connection.lego2 = map.get(words[3]);
		    connection.connectionPoint1 = words[2];
		    connection.connectionPoint2 = words[4];
		    connections.add(connection);
		    connectionsSize++;
		    /*
		     * String cp1 = connection.connectionPoint1; if((cp1.equals("bottom") ||
		     * cp1.equals("bottomA") || cp1.equals("bottomB") || cp1.equals("bottomC"))) {
		     * connection.lego1.connectUpward = false; }
		     * 
		     * String cp2 = connection.connectionPoint2; if((cp2.equals("bottom") ||
		     * cp2.equals("bottomA") || cp2.equals("bottomB") || cp2.equals("bottomC"))) {
		     * connection.lego2.connectUpward = false; }
		     */
		}

	    }

	} catch (IOException e) {
	    System.out.println("IOexception");
	}

	assemblyStation.setSlotSpacing(biggestX, biggestZ);

	Iterator it = map.entrySet().iterator();
	DigitalPart lego;
	int index = 0;
	while (it.hasNext()) {
	    HashMap.Entry pair = (HashMap.Entry) it.next();
	    lego = (DigitalPart) pair.getValue();
	    // lego.startLocation = new Vector3f(6.0f - 12.0f * (index%2),
	    // assemblySurfaceHeight + Main.dim, -4.0f - 2.0f * (index/2));
	    lego.startLocation = assemblyStation.slotPosition(index, lego.getYextent());
	    lego.translate(lego.startLocation);
	    // it.remove(); // avoids a ConcurrentModificationException
	    index++;
	}

	// Now go through the lego connections and translate each lego into the correct
	// place
	// We iterate until we find an unconnected connection involving one lego that
	// was already assembled
	// With this tactic, we have to iterate over the connections several times until
	// everything is connected
	boolean allConnected = false;
	while (!allConnected) {
	    allConnected = true;
	    Iterator<LegoConnection> itr = connections.iterator();
	    while (itr.hasNext()) {
		Vector3f connectionPoint;

		LegoConnection connection = itr.next();
		if (connection.connected) {

		    continue;
		}
		allConnected = false;
		if (connection.lego1.assembled && !connection.lego2.assembled) {
		    connectionPoint = connection.lego1.getConnectionPoint(connection.connectionPoint1);
		    // System.out.println(connectionPoint.toString());
		    // Now translate lego2 to the connectionPoint of lego1
		    connection.lego2.translateTarget(connectionPoint);
		    // System.out.println(connection.lego2.targetLocation.toString());
		    // Now translate lego2 so that its appropriate connectionPoint is being
		    // connected
		    connection.lego2.translateConnectionPoint(connection.connectionPoint2);
		    // System.out.println(connection.lego2.targetLocation.toString());
		    connection.lego2.assembled = true;
		    connection.lego2.assemblyLocation = connection.lego2.targetLocation;
		    connection.connected = true;
		}

		if (!connection.lego1.assembled && connection.lego2.assembled) {
		    connectionPoint = connection.lego2.getConnectionPoint(connection.connectionPoint2);
		    // Now translate lego1 to the connectionPoint of lego2
		    connection.lego1.translateTarget(connectionPoint);
		    // Now translate lego1 so that its appropriate connectionPoint is being
		    // connected
		    connection.lego1.translateConnectionPoint(connection.connectionPoint1);
		    connection.lego1.assembled = true;
		    connection.lego1.assemblyLocation = connection.lego1.targetLocation;
		    connection.connected = true;
		}
	    }
	}
	legosSize = legos.size();
	lego = legos.get(0);
	lego.moving = true;

	float bottom = 1000;
	for (int i = 0; i < legosSize; i++) {
	    legos.get(i).assembled = false;
	    if (legos.get(i).assemblyLocation.getY() < bottom) {
		bottom = legos.get(i).assemblyLocation.getY();
	    }
	}
	for (int i = 0; i < legosSize; i++) {
	    if (legos.get(i).assemblyLocation.getY() < bottom + 0.001f) {
		legos.get(i).bottomLayer = true;
		mobileRobot.addToQueue(legos.get(i));
	    }
	}
	float distanceToFloor = bottom - assemblySurfaceHeight - lego.getYextent(); // 3*Main.dim;
	for (int i = 0; i < legosSize; i++) {
	    legos.get(i).assemblyLocation.setY(legos.get(i).assemblyLocation.getY() - distanceToFloor);
	}
    }

    // goes through all elements in list "legos" and puts unassembled legos into the
    // list "unassembledLegos"
    // if they have a connection to an assembled lego
    // then it goes through the list again and returns the one with the lowest "y"
    // assembly location
    public DigitalPart nextUnassembledLego() throws UnknownHostException, IOException {
	unassembledLegos.clear();
	for (int i = 0; i < legosSize; i++) {
	    if (legos.get(i).assembled == false) {
		for (int j = 0; j < connections.size(); j++) {
		    LegoConnection conn = (LegoConnection) connections.get(j);
		    if (conn.lego1 == legos.get(i)) {
			if (conn.lego2.assembled) {
			    unassembledLegos.add(legos.get(i));
			}
		    }
		    if (conn.lego2 == legos.get(i)) {
			if (conn.lego1.assembled) {
			    unassembledLegos.add(legos.get(i));
			}
		    }
		}
	    }
	}
	if (unassembledLegos.isEmpty()) {
//uncomment
	    String stopp = new String("Stop");
	    // socket.InitializeSocket();
	    // socket.sendCommand(stopp);

	    System.out.println("all connected");
	    return null;

	}
	DigitalPart retVal = unassembledLegos.get(0);
	int index = 0;
	for (int k = 1; k < unassembledLegos.size(); k++) {
	    if (unassembledLegos.get(k).assemblyLocation.getY() < retVal.assemblyLocation.getY()) {
		retVal = unassembledLegos.get(k);
		index = k;
	    }
	}
	if (!physicalAssembly) {
	    mobileRobot.addToQueue(retVal);
	}
	return retVal;
    }

    public void immediateAssembly() {
	for (int i = 0; i < legosSize; i++) {
	    legos.get(i).translate(legos.get(i).targetLocation);
	    if (legos.get(i).northSouthOrientation()) {
		legos.get(i).node.rotate(0, FastMath.HALF_PI, 0);
	    }
	}
    }

    public void collisionDetected() {
	collisionDetection = false;
	assemblyArm.rotateBack();
	assemblyArm.initRotate(this);
	rotationMotion = false; // in case a rotation was in progress, we clear this boolean
	createUnderneathApproachTrajectory();
    }

    public void createUnderneathApproachTrajectory() {
	trajectory = new Trajectory();
	Vector3f v = lego.startLocation;
	v = v.add(new Vector3f(0, 2.0f * Main.dim, 0));

	assemblyArm.initMove(v, this);
	// Main.markerGeom.setLocalTranslation(v);
	count++;
	/*
	 * if (count > 4) { RobotArm.step = 0.01f; // RobotArm.maxRotationStep = 500; }
	 */

	gotoLego = true;
	Vector3f v0 = new Vector3f(lego.startLocation);
	v0.setY(maxHeight);
	trajectory.addPoint(v0);
	Vector3f v1 = new Vector3f(lego.assemblyLocation);
	v1.setY(maxHeight);
	if (!physicalAssembly) {
	    lego.approachAttempt += 1;
	}

	if (lego.approachAttempt == 1) { // towards negative X axis
	    trajectory.addPoint(v1.add(new Vector3f(20f * Main.dim, 0, 0)));
	    if (lego.northSouthOrientation()) {
		trajectory.addRotateMove(new Vector3f(0, FastMath.HALF_PI, 0));
	    }
	    Vector3f v3 = new Vector3f(lego.assemblyLocation.add(new Vector3f(30f * Main.dim, 2f * Main.dim, 0)));
	    trajectory.addPoint(v3);
	    if (lego.northSouthOrientation()) {
		trajectory.addRotateMove(new Vector3f(FastMath.HALF_PI, 0, 0));
	    } else {
		trajectory.addRotateMove(new Vector3f(0, 0, -FastMath.HALF_PI));
	    }
	    trajectory.addPoint(
		    new Vector3f(lego.assemblyLocation.add(new Vector3f(20f * Main.dim, -4.5f * Main.dim, 0))));
	    trajectory.addPoint(new Vector3f(lego.assemblyLocation.add(new Vector3f(0, -4.5f * Main.dim, 0))));
	    trajectory.addPoint(new Vector3f(lego.assemblyLocation.add(new Vector3f(0, 0f * Main.dim, 0)))); // used to
													     // be 2f
													     // instead
													     // of 0f
													     // for y
													     // coordinate
	    lego.node.rotate(FastMath.PI, 0, 0);
	} else if (lego.approachAttempt == 2) { // toward positive X axis
	    trajectory.addPoint(v1.add(new Vector3f(-27f * Main.dim, 0, 0)));
	    if (lego.northSouthOrientation()) {
		trajectory.addRotateMove(new Vector3f(0, FastMath.HALF_PI, 0));
	    }
	    Vector3f v3 = new Vector3f(lego.assemblyLocation.add(new Vector3f(-27f * Main.dim, 0.5f * Main.dim, 0)));
	    trajectory.addPoint(v3);
	    if (lego.northSouthOrientation()) {
		trajectory.addRotateMove(new Vector3f(-FastMath.HALF_PI, 0, 0));
	    } else {
		trajectory.addRotateMove(new Vector3f(0, 0, FastMath.HALF_PI));
	    }
	    trajectory.addPoint(
		    new Vector3f(lego.assemblyLocation.add(new Vector3f(-20f * Main.dim, -4.5f * Main.dim, 0))));
	    trajectory.addPoint(new Vector3f(lego.assemblyLocation.add(new Vector3f(0, -4.5f * Main.dim, 0))));
	    trajectory.addPoint(new Vector3f(lego.assemblyLocation.add(new Vector3f(0, 0f * Main.dim, 0))));
	    if (physicalAssembly) {
		lego.node.rotate(FastMath.PI, 0, 0);
	    }
	} else if (lego.approachAttempt == 3) { // toward positive Z axis
	    trajectory.addPoint(v1.add(new Vector3f(0, 0, -15f * Main.dim)));
	    if (lego.northSouthOrientation()) {
		trajectory.addRotateMove(new Vector3f(0, FastMath.HALF_PI, 0));
	    }
	    Vector3f v3 = new Vector3f(lego.assemblyLocation.add(new Vector3f(0, 2f * Main.dim, -15f * Main.dim)));
	    trajectory.addPoint(v3);
	    if (lego.northSouthOrientation()) {
		trajectory.addRotateMove(new Vector3f(0, 0, -FastMath.HALF_PI));
	    } else {
		trajectory.addRotateMove(new Vector3f(-FastMath.HALF_PI, 0, 0));
	    }
	    trajectory.addPoint(
		    new Vector3f(lego.assemblyLocation.add(new Vector3f(0, -4.5f * Main.dim, -5f * Main.dim))));
	    trajectory.addPoint(new Vector3f(lego.assemblyLocation.add(new Vector3f(0, -4.5f * Main.dim, 0))));
	    trajectory.addPoint(new Vector3f(lego.assemblyLocation.add(new Vector3f(0, 0f * Main.dim, 0))));
	    if (physicalAssembly) {
		lego.node.rotate(FastMath.PI, 0, 0);
	    }
	} else if (lego.approachAttempt == 4) { // toward negative Z axis
	    trajectory.addPoint(v1.add(new Vector3f(0, 0, 15f * Main.dim)));
	    if (lego.northSouthOrientation()) {
		trajectory.addRotateMove(new Vector3f(0, FastMath.HALF_PI, 0));
	    }
	    Vector3f v3 = new Vector3f(lego.assemblyLocation.add(new Vector3f(0, 2f * Main.dim, 15f * Main.dim)));
	    trajectory.addPoint(v3);
	    if (lego.northSouthOrientation()) {
		trajectory.addRotateMove(new Vector3f(0, 0, FastMath.HALF_PI));
	    } else {
		trajectory.addRotateMove(new Vector3f(FastMath.HALF_PI, 0, 0));
	    }
	    trajectory.addPoint(
		    new Vector3f(lego.assemblyLocation.add(new Vector3f(0, -4.5f * Main.dim, 5f * Main.dim))));
	    trajectory.addPoint(new Vector3f(lego.assemblyLocation.add(new Vector3f(0, -4.5f * Main.dim, 0))));
	    trajectory.addPoint(new Vector3f(lego.assemblyLocation.add(new Vector3f(0, 0f * Main.dim, 0))));
	    if (physicalAssembly) {
		lego.node.rotate(FastMath.PI, 0, 0);
	    }
	} else {
	    Main.helloText.setText("Unable to assemble this product due to collisions");
	    Main.freeze = true;
	}
	trajectory.initTrajectory();
	trajectoryMotion = true;
    }

    /*
     * public boolean virtualAssemblyComplete() { return virtualAssemblyComplete; }
     */
    public void execute(float tpf) throws IOException, IOException {
	/*
	 * if (connectingUpward) { Main.helloText.setText("Up"); } else {
	 * Main.helloText.setText("Down"); }
	 */
	// physical assembly

	// GREEN CODE STARTS HERE
	if (waitingForLego) {

	    if (lego.state == LegoState.AtAssembly) {

		waitingForLego = false;

	    } else {

		return;

	    }

	}
	// GREEN CODE ENDS HERE

	if (!physicalAssembly && virtualAssemblyComplete) {
	    // Main.freeze = true;
	    initPhysicalAssembly();
	    RobotArm.step *= 2;
	    // RobotArm.maxRotationStep = 1000;
	    return;
	}

	if (gotoLego) { // moving to lego start position
	    if (initialRotation) { // rotate before going to lego
		if (assemblyArm.rotate(trajectoryPoint, false)) {
		    initialRotation = false;
		    return;
		} else {
		    return;
		}
	    }

	    // BLUE CODE STARTS HERE
	    gotoLego = assemblyArm.move();
	    // BLUE CODE ENDS HERE

	    /*
	     * if(!gotoLego && (lego.orientation.getZ() > 0.1f)) { Main.freeze = true;
	     * return; }
	     */

	    if (collisionDetection) {
		assemblyArm.checkCollision();
	    }

	    if (!gotoLego && !assemblyArm.legoAttached()) {
		/*
		 * if(legoNum == 2) { lego.connectArm(assemblyArm);
		 * lego.node.setLocalTranslation(0, -3.0f * Main.dim - lego.getYextent(), 0);
		 * Main.freeze = true; return; } else {
		 */

		String rotation = new String();
		if (lego.northSouthOrientation()) {
		    trajectory.addRotateMove(new Vector3f(0, FastMath.HALF_PI, 0));
		    String rota = new String("90");

		    // System.out.println(lego.id + " " + rota);
		    rotation = rota;

		} else {
		    String rotno = new String("00");
		    rotation = rotno;

		}

		Vector3f y = lego.targetLocation.subtract(legos.get(0).targetLocation);

		System.out.println(lego.id + " " + y);

//uncomment	

		// socket.InitializeSocket();
		// socket.sendCommand1(lego.id, y, rotation);

		lego.connectArm(assemblyArm);

		/*
		 * if(lego.orientation != null) { if(lego.orientation.getZ() > 0.1f) {
		 * System.out.println(lego.getXextent()); System.out.println(lego.getYextent());
		 * System.out.println(lego.getZextent());
		 * lego.node.setLocalRotation(Quaternion.ZERO);
		 * lego.node.setLocalTranslation(-1f*lego.getXextent(), -3*Main.dim,
		 * 1f*lego.getYextent()); } } else {
		 */
		lego.node.setLocalTranslation(0, -3.0f * Main.dim - lego.getYextent(), 0);
		// }
		/*
		 * if(lego.orientation.getZ() > 0.1f) { Main.freeze = true; return; }
		 */
		// lego.node.setLocalTranslation(0, -4.0f * Main.dim, 0);

	    }
	    return; // we do not go on to do any of the other motions that apply to the case that we
		    // have gripped a lego
	}

	if (trajectoryMotion) {
	    if (assemblyInProgress) {
		assemblyInProgress = assemblyArm.move();
		if (collisionDetection && connectingUpward && lego.isLego()) {
		    assemblyArm.checkCollision();
		}
		return;
	    }

	    if (rotationMotion) {
		boolean bothJoints = true;
		if (lego.orientation != null) {
		    if (lego.orientation.getZ() > 0.1f) {
			bothJoints = false;
		    }
		}
		boolean ready = assemblyArm.rotate(trajectoryPoint, bothJoints);
		if (collisionDetection && lego.isLego()) {
		    assemblyArm.checkCollision();
		}
		if (ready) {
		    rotationMotion = false;
		} else {
		    return;
		}

	    }
	    trajectoryPoint = trajectory.nextPoint();
	    if (!virtualAssemblyComplete) {
		collisionDetection = true; // it will be set to true when the arm is at lego start position with lego on
					   // board
	    }
	    if (trajectoryPoint == null) { // we are done with this lego
		/*
		 * if(lego.id.equalsIgnoreCase("rect11")) { Main.freeze = true; return; }
		 */
		legoNum++;
		// approachAttempt = 1; // reset for next lego
		lego.location = lego.node.getWorldTranslation();
		trajectoryMotion = false;
		lego.assembled = true;

		lego.disconnectArm();
		node.attachChild(lego.node);
		if (connectingUpward) {
		    assemblyArm.rotateBack();
		    connectingUpward = false;
		    lego.node.rotate(FastMath.PI, 0, 0);
		    // assemblyArm.step = 0.05f;
		} else {
		    assemblyArm.initRotate(this); // initRotate resets everything else apart from the y rotation
		    assemblyArm.rotateBack();
		}

	    } else {
		if (trajectory.rotationMotion()) {
		    assemblyArm.initRotate(this);
		    rotationMotion = true;
		    return;
		}
		assemblyArm.initMove(trajectoryPoint, this);

		if (lego.id.equalsIgnoreCase("rect2")) {
		    // Main.helloText.setText(lego.assemblyLocation.toString() + " : " +
		    // lego.targetLocation.toString());
		}

		assemblyInProgress = true;
		return;
	    }
	}

	// if we get down here it means that the previous lego was assembled and now we
	// need to find the next lego
	collisionDetection = false;
	if (bottomReady) {
	    // RED CODE STARTS HERE
	    lego = nextUnassembledLego();
	    // RED CODE ENDS HERE
	    if (lego == null) {
		if (physicalAssembly) {
		    Main.freeze = true;
		    cell.getMobileRobot().start = false;
		    return;
		}
		virtualAssemblyComplete = true;
		return;
	    }
	    if (physicalAssembly && (lego.state != LegoState.AtAssembly)) {
		// System.out.println("WAITING for: " + lego.id);
		waitingForLego = true;
	    }

	    if (connectUpward(lego)) {
		connectingUpward = true;
		createUnderneathApproachTrajectory();
		// lego.node.rotate(FastMath.PI, 0, 0);
		return;
	    }

	    trajectory = new Trajectory();
	    if (lego.rotationAxis.equalsIgnoreCase("z")) {
		trajectoryPoint = new Vector3f(FastMath.HALF_PI, 0, 0);
		initialRotation = true;
	    }
	    lego.moving = false;
	    if (lego.rotationAxis.equalsIgnoreCase("z")) {
		// assemblyArm.step = 0.05f;
		// RobotArm.maxRotationStep = 500;
		Vector3f v = lego.startLocation.add(new Vector3f(0, 0, lego.getZextent()));
		assemblyArm.initMove(v, this);
		assemblyArm.connectionPoint = "z";

	    } else {
		assemblyArm.initMove(lego.startLocation.add(lego.getGripperOffset()), this);
		assemblyArm.connectionPoint = null;
	    }

	    gotoLego = true;
	    Vector3f v0 = new Vector3f(lego.startLocation);
	    v0.setY(maxHeight);
	    trajectory.addPoint(v0);
	    /*
	     * Vector3f v1 = new Vector3f(lego.startLocation); v1.setY(maxHeight);
	     * trajectory.addPoint(v1);
	     */

	    Vector3f v2 = new Vector3f(lego.assemblyLocation);
	    v2.setY(maxHeight);
	    trajectory.addPoint(v2);

	    /*
	     * if(lego.northSouthOrientation()) { trajectory.addRotateMove(new
	     * Vector3f(0,FastMath.HALF_PI,0)); String rota = new String("90");
	     * //System.out.println(rota); socket sock = new socket();
	     * sock.sendCommand(lego.id,v2,rota);
	     * 
	     * 
	     * } else { String rotno = new String("00"); System.out.println(lego.id + " " +
	     * rotno); socket sock = new socket(); sock.sendCommand(lego.id,v2, rotno);
	     * 
	     * }
	     */
	    if (!lego.isLego() && (!lego.orientationZero)) {
		trajectory.addRotateMove(lego.orientation);
	    }
	    trajectory.addPoint(lego.assemblyLocation.add(lego.getGripperOffset()));

	    trajectory.initTrajectory();
	    trajectoryMotion = true;
	    return;
	}

	// if we get down here it means that the bottom layer is not yet assembled
	boolean unassembledBottomLegoExists = false; // ready = true;
	// look for an unassembled bottom layer lego
	for (int i = 0; i < legosSize; i++) {
	    if (legos.get(i).bottomLayer && !legos.get(i).assembled) {
		unassembledBottomLegoExists = true;

		trajectory = new Trajectory();
		lego = legos.get(i);
		lego.moving = false;
		assemblyArm.initMove(lego.startLocation.add(lego.getGripperOffset()), this);
		Main.markerGeom.setLocalTranslation(lego.startLocation.add(lego.getGripperOffset()));
		gotoLego = true;
		Vector3f v1 = new Vector3f(lego.startLocation);
		v1.setY(maxHeight);
		trajectory.addPoint(v1);
		Vector3f v2 = new Vector3f(lego.assemblyLocation);
		v2.setY(maxHeight);
		trajectory.addPoint(v2);
		// trajectory.addPoint(new Vector3f(lego.assemblyLocation.add(new Vector3f(0,
		// 0.5f*Main.dim, 0))));
		trajectory.addPoint(lego.assemblyLocation.add(lego.getGripperOffset()));
		trajectory.initTrajectory();
		trajectoryMotion = true;
		if (physicalAssembly && (lego.state != LegoState.AtAssembly)) {
		    // System.out.println("WAITING for: " + lego.id);
		    waitingForLego = true;
		}
		return;
	    }
	}
	if (unassembledBottomLegoExists == false) {
	    bottomReady = true;

	}

    }

}
