package mygame;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.PrintStream;
import java.net.Socket;
import java.net.UnknownHostException;

import com.jme3.math.Vector3f;

public class socket {

    private static Socket socket;

    public static void InitializeSocket() {

	ObjectInputStream inStream = null;
	ObjectOutputStream outStream = null;

	try {
	    socket = new Socket("192.168.125.1", 4000);
	} catch (IOException e) {
	    // TODO Auto-generated catch block
	    e.printStackTrace();
	}

    }

    public static Socket getSocket() {
	return socket;
    }

    public static void sendCommand(String s) throws UnknownHostException, IOException {

	ObjectInputStream inStream = null;
	ObjectOutputStream outStream = null;

	PrintStream p = new PrintStream(socket.getOutputStream());
	p.println(s);

	InputStream input = socket.getInputStream();
	BufferedReader reader = new BufferedReader(new InputStreamReader(input));
	String line = reader.readLine();
	System.out.println(line);

	if (line.equals("received ")) {
	    System.out.println("continue");
	} else {
	    System.exit(0);
	    ;
	}

    }

    public static void sendCommand1(String s, Vector3f vec, String rt) throws UnknownHostException, IOException {

	ObjectInputStream inStream = null;
	ObjectOutputStream outStream = null;

	PrintStream p = new PrintStream(socket.getOutputStream());
	p.println(s + ";" + rt + ";" + vec.toString());
	// System.out.println(p);

	InputStream input = socket.getInputStream();
	BufferedReader reader = new BufferedReader(new InputStreamReader(input));
	String line = reader.readLine();
	// System.out.println(line);

	if (line.equals("received ")) {
	    System.out.println("done");
	} else {
	    System.exit(0);
	    ;
	}

    }

}
