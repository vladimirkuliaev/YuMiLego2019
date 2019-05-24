 MODULE MainModule
	PERS wobjdata wobj1:=[FALSE,TRUE,"",[[186.619,14.041,43.2433],[0.741199,0.00178913,-0.00792014,-0.671236]],[[0.796976,55.6561,0],[1,0,0,0.000286155]]];
    CONST string detectjob := "lct.job";
    CONST string readREDjob := "QR_Red.job";
    VAR cameratarget mycameratarget;
   
	CONST robtarget aboveWP:=[[10.04,5.14,80.52],[0.00194954,0.743988,0.668187,0.00183217],[1,2,-1,4],[157.199,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget startPoint:=[[266.38,-323.45,123.19],[0.264136,-0.898026,0.3062,0.173273],[1,3,-2,4],[-158.689,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget myrobtarget10:=[[200.32,218.76,74.49],[0.00104262,-0.924304,-0.381193,0.0187858],[1,2,1,4],[151.124,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget safeUp:=[[451.88,-197.47,103.88],[0.00870065,0.69364,-0.720166,-0.0122373],[1,3,0,4],[178.372,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget startPoint10:=[[253.71,-80.30,187.72],[0.0085022,-0.0615952,-0.99792,-0.0170172],[1,2,1,4],[-141.069,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget passPoint:=[[253.71,-80.30,187.72],[0.00850392,-0.061597,-0.99792,-0.0170158],[1,2,1,4],[-141.069,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget myrobtarget:=[[9.28,4.07,-0.32],[0.00195056,0.743987,0.668188,0.00183229],[1,2,-1,4],[157.198,9E+09,9E+09,9E+09,9E+09,9E+09]];
    
    
    VAR syncident sync1;
	VAR syncident sync2;
    VAR syncident sync3;
    VAR syncident sync4;
    VAR syncident sync5;
    VAR syncident sync6;
    VAR syncident sync7;
    VAR syncident sync8;
    VAR syncident sync9;
    VAR syncident sync10;
    
    PERS tasks tasklist{2}:=[["T_ROB_L"], ["T_ROB_R"]];
	CONST jointtarget photoPos:=[[50.7374,-108.633,53.0334,208.473,-1.17635,-97.3027],[-86.458,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST jointtarget photoPos10:=[[80.6834,-101.674,35.5473,256.881,-57.7592,-178.45],[-113.714,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget passPoint10:=[[253.71,-209.99,187.72],[0.00851123,-0.0616072,-0.997919,-0.0170138],[1,2,0,4],[-141.069,9E+09,9E+09,9E+09,9E+09,9E+09]];
    
    VAR bool yellow :=FALSE;
    VAR bool white :=FALSE;
    VAR bool red :=FALSE;
    VAR bool blue :=FALSE;
    VAR bool green :=FALSE;
    VAR bool blue_in_place :=FALSE;
    VAR bool green_in_place :=FALSE;
    VAR bool yellow_in_place :=FALSE;
    VAR bool white_in_place :=FALSE;
    VAR bool red_in_place :=FALSE;
    
    VAR bool ready :=FALSE;
    
	VAR cameratarget cameratarget1;
	CONST robtarget aboveWP10:=[[262.50,42.02,19.97],[0.00702238,0.738477,-0.674185,-0.00874356],[1,3,0,4],[153.482,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget aboveWP20:=[[458.31,24.25,71.33],[0.00629773,0.68095,-0.732244,-0.00930247],[1,3,0,4],[153.482,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget aboveWP30:=[[454.62,24.41,50.10],[0.00629827,0.680952,-0.732242,-0.00930283],[1,3,0,4],[153.481,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget aboveWP40:=[[454.62,24.41,65.21],[0.0062994,0.68095,-0.732244,-0.00930237],[1,3,0,4],[153.481,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget aboveWP50:=[[454.62,50.65,62.50],[0.00629821,0.68095,-0.732244,-0.00929812],[2,3,0,4],[153.48,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget aboveWP60:=[[454.62,50.63,48.68],[0.00631059,0.680948,-0.732245,-0.00929163],[2,3,0,4],[153.479,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget aboveWP70:=[[454.62,43.34,48.68],[0.00631171,0.680947,-0.732246,-0.00929236],[2,3,0,4],[153.479,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget aboveWP80:=[[454.62,55.53,48.68],[0.00631106,0.680947,-0.732247,-0.00929061],[2,3,0,4],[153.479,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget aboveWP90:=[[496.50,55.53,75.78],[0.00630719,0.680947,-0.732247,-0.00928447],[2,3,0,4],[153.479,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget aboveWP100:=[[496.50,24.19,75.78],[0.00631004,0.680945,-0.732249,-0.0092846],[2,3,0,4],[153.478,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget aboveWP110:=[[496.52,24.13,75.78],[0.00214193,-0.999409,0.0324964,0.0110175],[2,3,-1,4],[153.478,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget aboveWP120:=[[496.52,24.14,50.04],[0.00214212,-0.999409,0.0324936,0.011017],[2,3,-1,4],[153.477,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget aboveWP130:=[[481.02,24.14,50.04],[0.00214223,-0.999409,0.0324931,0.0110165],[2,3,-1,4],[153.477,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget aboveWP140:=[[490.42,24.13,50.04],[0.00213632,-0.999409,0.032496,0.0110142],[2,3,-1,4],[153.477,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget aboveWP150:=[[490.42,24.13,73.57],[0.00213405,-0.999409,0.0324978,0.0110113],[2,3,-1,4],[153.477,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget aboveWP160:=[[456.36,20.73,54.91],[0.0180065,-0.999647,-0.0137112,0.0138836],[1,3,-1,4],[153.975,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget aboveWP170:=[[420.01,24.11,73.56],[0.0021187,-0.999409,0.0325046,0.0110179],[1,3,-1,4],[153.477,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget aboveWP180:=[[420.01,24.09,50.17],[0.0021036,-0.999408,0.0325085,0.0110247],[1,3,-1,4],[153.477,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget aboveWP190:=[[430.11,24.09,50.17],[0.00210359,-0.999408,0.0325103,0.011026],[1,3,-1,4],[153.477,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget aboveWP200:=[[424.14,24.09,50.17],[0.00210401,-0.999408,0.0325103,0.011026],[1,3,-1,4],[153.477,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget aboveWP210:=[[424.14,24.09,80.42],[0.00210221,-0.999408,0.0325109,0.0110248],[1,3,-1,4],[153.477,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget aboveWP220:=[[453.59,24.09,80.42],[0.00210025,-0.999408,0.0325118,0.0110221],[1,3,-1,4],[153.477,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget aboveWP230:=[[456.36,20.71,90.08],[0.0179907,-0.999648,-0.0137035,0.013888],[1,3,-1,4],[153.975,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget aboveWP240:=[[456.36,20.71,90.08],[0.0179898,-0.999648,-0.0137036,0.0138892],[1,3,-1,4],[153.975,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget floor2:=[[456.17,24.23,71.32],[0.00631087,0.680946,-0.732248,-0.00929786],[1,3,0,4],[153.482,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget floor12:=[[456.17,24.23,60.42],[0.00631093,0.680945,-0.732248,-0.00929792],[1,3,0,4],[153.482,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget floor22:=[[456.17,44.19,71.31],[0.00632586,0.680942,-0.732251,-0.0092921],[1,3,0,4],[153.482,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget floor32:=[[456.17,45.34,56.30],[0.00632468,0.680943,-0.73225,-0.00929128],[2,3,0,4],[153.481,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget floor42:=[[456.17,43.71,56.30],[0.00632329,0.680942,-0.732251,-0.00929227],[2,3,0,4],[153.48,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget floor52:=[[456.20,53.78,56.30],[0.00632235,0.680943,-0.73225,-0.00929103],[2,3,0,4],[153.48,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget floor62:=[[456.20,53.78,83.10],[0.00632432,0.680942,-0.732251,-0.00928933],[1,3,0,4],[153.48,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget floor72:=[[492.81,22.40,83.10],[0.00632226,0.680942,-0.732251,-0.00928759],[1,3,0,4],[153.479,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget floor82:=[[492.87,22.42,83.10],[0.0110481,-0.0434475,-0.998993,-0.00202396],[1,3,1,4],[153.479,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget floor92:=[[492.87,22.42,59.95],[0.0110464,-0.0434492,-0.998993,-0.00202316],[2,3,1,4],[153.478,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget floor102:=[[480.78,22.42,59.95],[0.0110476,-0.0434492,-0.998993,-0.00202138],[2,3,1,4],[153.477,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget floor112:=[[498.49,22.41,75.55],[0.011036,-0.0434519,-0.998993,-0.00201052],[2,3,1,4],[153.477,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget floor122:=[[419.30,22.41,75.55],[0.0110417,-0.043456,-0.998992,-0.0020105],[1,3,1,4],[153.477,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget floor132:=[[429.61,26.06,56.49],[0.0110399,-0.0434531,-0.998992,-0.00201012],[1,3,1,4],[153.477,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget floor142:=[[409.35,26.06,71.28],[0.0110395,-0.043454,-0.998992,-0.00200675],[1,3,1,4],[153.477,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget floor152:=[[452.35,-2.01,71.28],[0.0110359,-0.0434544,-0.998992,-0.00200754],[1,3,1,4],[153.476,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget floor162:=[[452.35,-2.01,55.74],[0.0110368,-0.0434533,-0.998993,-0.00200545],[1,3,1,4],[153.476,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget floor172:=[[452.35,9.70,55.74],[0.0110353,-0.0434537,-0.998993,-0.0020077],[1,3,1,4],[153.476,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget floor182:=[[452.35,0.17,67.06],[0.0110352,-0.0434537,-0.998993,-0.00200676],[1,3,1,4],[153.476,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget floor192:=[[452.35,25.23,74.56],[0.011032,-0.0434539,-0.998993,-0.00200736],[1,3,1,4],[153.475,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget floor202:=[[452.92,28.61,63.68],[0.00126995,0.00955331,-0.999856,0.0139835],[1,3,1,4],[156.397,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget floor212:=[[452.94,28.28,73.06],[0.00133556,0.00933585,-0.999849,0.0146266],[1,3,1,4],[156.363,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget floor222:=[[446.97,27.99,95.74],[0.00862998,-0.0208298,-0.999697,0.00986564],[1,3,1,4],[153.836,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget floor232:=[[447.40,28.40,66.51],[0.00827314,-0.0211588,-0.999703,0.00882712],[1,3,1,4],[153.95,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget floor242:=[[446.97,27.99,95.91],[0.00862664,-0.0208302,-0.999697,0.00986575],[1,3,1,4],[153.836,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget floor252:=[[453.43,19.41,126.85],[0.0174637,-0.0228552,-0.998993,0.034441],[1,3,1,4],[153.77,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget floor262:=[[453.43,-212.51,126.85],[0.0174588,-0.0228532,-0.998993,0.034443],[1,3,1,4],[153.77,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget safeUp10:=[[319.34,-73.36,189.82],[0.10164,0.738029,-0.66437,0.0599575],[1,2,0,4],[-164.153,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget aboveWP250:=[[447.96,24.92,77.48],[0.010928,-0.643277,0.765552,-0.00234169],[1,2,0,4],[-175.395,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget aboveWP260:=[[448.32,25.54,69.39],[0.0107708,-0.687358,0.726232,-0.00298403],[1,2,0,4],[-175.394,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget aboveWP270:=[[448.32,25.54,83.88],[0.0107711,-0.687357,0.726234,-0.00298546],[1,2,0,4],[-175.394,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget aboveWP280:=[[448.32,47.56,83.88],[0.0107714,-0.687357,0.726233,-0.00298611],[1,2,0,4],[-175.394,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget aboveWP290:=[[448.32,47.55,68.25],[0.0107717,-0.687357,0.726233,-0.00298557],[1,2,0,4],[-175.394,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget aboveWP300:=[[448.32,42.89,68.25],[0.0107722,-0.687359,0.726232,-0.00298747],[1,2,0,4],[-175.393,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget aboveWP310:=[[492.02,22.95,86.75],[0.00971065,0.0328106,0.999399,0.00555773],[1,3,1,4],[-175.393,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget aboveWP320:=[[492.02,22.95,70.26],[0.00971239,0.0328108,0.999399,0.00555609],[1,3,1,4],[-175.393,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget aboveWP330:=[[475.76,22.95,70.26],[0.00971375,0.0328105,0.999399,0.00555645],[1,3,1,4],[-175.393,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget aboveWP340:=[[417.06,22.95,85.58],[0.00971085,0.0328128,0.999399,0.00555814],[1,2,1,4],[-175.392,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget aboveWP350:=[[417.06,22.95,66.65],[0.00971141,0.032813,0.999399,0.00555769],[1,2,1,4],[-175.392,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget aboveWP360:=[[424.29,22.95,66.65],[0.00971093,0.0328128,0.999399,0.00555672],[1,2,1,4],[-175.391,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget aboveWP370:=[[448.99,0.32,88.69],[0.00971669,0.0328153,0.999399,0.00555338],[1,2,1,4],[-175.389,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget aboveWP380:=[[448.99,0.31,67.46],[0.00971881,0.0328164,0.999399,0.00555259],[1,2,1,4],[-175.388,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget aboveWP390:=[[438.24,9.58,67.46],[0.00971912,0.0328163,0.999399,0.0055538],[1,2,1,4],[-175.387,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget aboveWP400:=[[452.89,23.13,90.84],[0.00972105,0.0328154,0.999399,0.00555112],[1,2,1,4],[-175.386,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget aboveWP410:=[[450.69,20.29,81.52],[0.00829293,0.0398968,0.99897,0.0199494],[1,3,1,4],[-178.145,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget aboveWP420:=[[450.69,20.29,72.25],[0.00829189,0.0398974,0.99897,0.0199499],[1,3,1,4],[-178.145,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget aboveWP430:=[[453.32,50.61,86.74],[0.00969977,0.0328153,0.999399,0.00554626],[1,2,1,4],[-175.393,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST jointtarget photoPos20:=[[53.6922,-67.624,49.9305,274.915,-40.6568,-146.833],[-99.2732,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget passPoint20:=[[253.71,-195.94,187.72],[0.00851045,-0.0616068,-0.997919,-0.0170145],[1,2,1,4],[-141.069,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget aboveWP440:=[[455.30,0.44,80.41],[0.00208294,-0.999408,0.0325202,0.0110275],[1,3,-1,4],[153.476,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget aboveWP450:=[[455.30,0.44,51.52],[0.00208284,-0.999408,0.0325167,0.0110258],[1,3,-1,4],[153.476,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget aboveWP460:=[[455.30,10.51,51.52],[0.00208341,-0.999408,0.0325183,0.0110275],[1,3,-1,4],[153.476,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget passPoint30:=[[412.01,-175.97,158.16],[0.00851856,-0.0616192,-0.997918,-0.0170141],[1,2,0,4],[-141.067,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget passPoint40:=[[412.01,-175.97,55.73],[0.0085216,-0.0616192,-0.997918,-0.0170091],[1,2,0,4],[-141.065,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget above_blue_piece:=[[412.00,-175.98,97.27],[0.0085328,-0.061629,-0.997918,-0.0170061],[1,2,0,4],[-141.063,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget at_blue_piece:=[[412.01,-176.06,45.54],[0.00834812,-0.0616105,-0.99793,-0.0164478],[1,2,0,4],[-141.064,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget above_green_piece:=[[414.11,-106.77,97.67],[0.00853287,-0.061626,-0.997918,-0.0170084],[1,2,1,4],[-141.061,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget at_green_piece:=[[414.10,-106.77,48.53],[0.00853392,-0.0616244,-0.997918,-0.0170047],[1,2,0,4],[-141.06,9E+09,9E+09,9E+09,9E+09,9E+09]];
    
VAR bool first_done :=FALSE;
VAR bool second_done :=FALSE;
VAR bool third_done :=FALSE;
CONST robtarget passPoint50:=[[460.72,-106.35,69.84],[0.0085238,-0.0616418,-0.997917,-0.0169866],[1,2,0,4],[-141.061,9E+09,9E+09,9E+09,9E+09,9E+09]];
CONST robtarget passPoint60:=[[460.72,-106.35,45.95],[0.0085232,-0.0616436,-0.997917,-0.0169852],[1,2,0,4],[-141.06,9E+09,9E+09,9E+09,9E+09,9E+09]];
CONST robtarget passPoint70:=[[461.75,-175.97,103.63],[0.0085321,-0.0616276,-0.997918,-0.0170051],[1,2,0,4],[-141.063,9E+09,9E+09,9E+09,9E+09,9E+09]];
CONST robtarget passPoint80:=[[461.75,-175.98,47.12],[0.00853214,-0.0616288,-0.997918,-0.017002],[1,2,0,4],[-141.062,9E+09,9E+09,9E+09,9E+09,9E+09]];
	PROC main()
       preparation;
       Stop;
       Hand_SetHoldForce(12);
       build_first_floor;
       
       
       build_second_floor;
       
       build_third_floor;
       Stop;
       
       
	ENDPROC
    
    PROC preparation()
        g_SetForce 5;
		g_SetMaxSpd 3;
		g_JogOut;
		g_JogIn;
		g_Calibrate;
		g_JogIn;
		!MoveJ startPoint, v1000, z50, tool0\WObj:=wobj0;
	    CamSetProgramMode upCam;
        CamLoadJob upCam, detectjob;
        CamSetRunMode upCam;
        CamSetProgramMode rightHand;
        CamLoadJob rightHand, readREDjob;
        CamSetRunMode rightHand;
    ENDPROC
    
    PROC build_first_floor()
		
    
        
        MoveJ safeUp, v4000, z50, tool0\WObj:=wobj0;
        
        CamReqImage upCam;
        CamGetResult upCam, mycameratarget;
        wobj1.oframe := mycameratarget.cframe;
        MoveJ safeUp, v4000, fine, tool0\WObj:=wobj0;
        MoveJ safeUp10, v4000, fine, tool0\WObj:=wobj0;
        MoveJ aboveWP, v2500, fine, tool0\WObj:=wobj1;
        
       
        g_GripOut;
        
        MoveL myrobtarget, v1000, fine, tool0 \WObj:=wobj1;
        g_GripIn;
        
		
        MoveJ aboveWP, v1000, fine, tool0\WObj:=wobj1;
        
                WaitSyncTask\InPos, sync1, tasklist;
        
        MoveJ passPoint, v1000, fine, tool0;
        
                WaitSyncTask\InPos, sync2, tasklist;
        
                WaitSyncTask\InPos, sync3, tasklist;
        
                WaitSyncTask\InPos, sync4, tasklist;
        g_MoveTo 10;
        MoveL passPoint10, v1000, z50, tool0;
        
                WaitSyncTask\InPos, sync5, tasklist;
        g_GripIn;
        MoveAbsJ photoPos\NoEOffs, v1000, z50, tool0;
        MoveAbsJ photoPos10\NoEOffs, v1000, z50, tool0;
                WaitSyncTask\InPos, sync6, tasklist;
        CamReqImage rightHand;
        
        CamGetResult rightHand, cameratarget1;
      
        
        IF cameratarget1.val2 = 1 
        THEN
        	yellow := NOT yellow;
            startbuilding_first;
        ELSEIF 
            cameratarget1.val1 = 1
        THEN 
            white := NOT white;
            put_to_white_pos;
        ELSEIF
            cameratarget1.val3 = 1
        THEN 
            red := NOT red;
            put_to_red_pos;
        ELSEIF
            cameratarget1.val4 = 1
        THEN 
            blue := NOT blue;
            put_to_blue_pos;
        ELSEIF
            cameratarget1.val5 = 1
        THEN 
            green := NOT green;
            put_to_green_pos;
        ENDIF
        
        
        
        
        ENDPROC
        
        PROC build_second_floor()
		
            IF blue_in_place  THEN
                MoveJ above_blue_piece, v1000, z50, tool0;
                g_MoveTo 10;
                MoveL at_blue_piece, v100, fine, tool0;
                g_GripIn;
                MoveL above_blue_piece, v1000, z50, tool0;
                startbuilding_second_straight;
        
            
            ELSE
                
               MoveJ safeUp, v1000, z50, tool0\WObj:=wobj0;
        
        CamReqImage upCam;
        CamGetResult upCam, mycameratarget;
        wobj1.oframe := mycameratarget.cframe;
        MoveJ safeUp, v1000, z50, tool0\WObj:=wobj0;
        MoveL aboveWP, v500, z100, tool0\WObj:=wobj1;
        
        
        
        
         
        
        g_MoveTo 15;
        
        MoveL myrobtarget, v1000, fine, tool0 \WObj:=wobj1;
        g_GripIn;
        
		
        MoveJ aboveWP, v1000, fine, tool0\WObj:=wobj1; 
        
         WaitSyncTask\InPos, sync1, tasklist;
        
        MoveJ passPoint, v1000, z50, tool0;
        
                WaitSyncTask\InPos, sync2, tasklist;
        
                WaitSyncTask\InPos, sync3, tasklist;
        
                WaitSyncTask\InPos, sync4, tasklist;
        g_MoveTo 10;
        MoveL passPoint10, v1000, z50, tool0;
        
                WaitSyncTask\InPos, sync5, tasklist;
        g_GripIn;
        MoveAbsJ photoPos\NoEOffs, v1000, z50, tool0;
        MoveAbsJ photoPos10\NoEOffs, v1000, z50, tool0;
                WaitSyncTask\InPos, sync6, tasklist;
        CamReqImage rightHand;
        
        CamGetResult rightHand, cameratarget1;
      
        
        IF 
            cameratarget1.val1 = 1
        THEN 
            white := NOT white;
            put_to_white_pos;
        ELSEIF
            cameratarget1.val3 = 1
        THEN 
            red := NOT red;
            put_to_red_pos;
        ELSEIF
            cameratarget1.val4 = 1
        THEN 
            blue := NOT blue;
            startbuilding_second;
        ELSEIF
            cameratarget1.val5 = 1
        THEN 
            green := NOT green;
            put_to_green_pos;
        ENDIF
        
        
        
        
            ENDIF
    
        
       
        
        ENDPROC
        
        PROC build_third_floor()
		
     IF green_in_place  THEN
         
                MoveJ above_green_piece, v1000, z50, tool0;
                g_MoveTo 10;
                MoveL at_green_piece, v100, fine, tool0;
                g_GripIn;
                MoveL above_green_piece, v1000, z50, tool0;
                startbuilding_third_straight;
        
            
            ELSE
        
         MoveJ safeUp, v1000, z50, tool0\WObj:=wobj0;
        
        CamReqImage upCam;
        CamGetResult upCam, mycameratarget;
        wobj1.oframe := mycameratarget.cframe;
        MoveJ safeUp, v1000, z50, tool0\WObj:=wobj0;
        MoveL aboveWP, v500, z100, tool0\WObj:=wobj1;
        
        
        
        
         
        
        g_MoveTo 15;
        
        MoveL myrobtarget, v1000, fine, tool0 \WObj:=wobj1;
        g_GripIn;
        
		
        MoveJ aboveWP, v1000, fine, tool0\WObj:=wobj1; 
        
        WaitSyncTask\InPos, sync1, tasklist;
        
        MoveJ passPoint, v1000, z50, tool0;
        
                WaitSyncTask\InPos, sync2, tasklist;
        
                WaitSyncTask\InPos, sync3, tasklist;
        
                WaitSyncTask\InPos, sync4, tasklist;
        g_MoveTo 10;
        MoveL passPoint10, v1000, z50, tool0;
        
                WaitSyncTask\InPos, sync5, tasklist;
        g_GripIn;
        MoveAbsJ photoPos\NoEOffs, v1000, z50, tool0;
        MoveAbsJ photoPos10\NoEOffs, v1000, z50, tool0;
                WaitSyncTask\InPos, sync6, tasklist;
        CamReqImage rightHand;
        
        CamGetResult rightHand, cameratarget1;
      
        
        IF 
            cameratarget1.val1 = 1
        THEN 
            white := NOT white;
            put_to_white_pos;
        ELSEIF
            cameratarget1.val3 = 1
        THEN 
            red := NOT red;
            put_to_red_pos;
       
        ELSEIF
            cameratarget1.val5 = 1
        THEN 
            green := NOT green;
            startbuilding_third;
        ENDIF
        
        
        
        
           
        
        
     ENDIF
        
        ENDPROC
     PROC startbuilding_first()
        MoveAbsJ photoPos\NoEOffs, v1000, z50, tool0;
        MoveAbsJ photoPos20\NoEOffs, v1000, z50, tool0;
        MoveJ passPoint10, v1000, z50, tool0;
        g_MoveTo 10;
        
        WaitSyncTask\InPos, sync7, tasklist;
        MoveL passPoint, v1000, z50, tool0;
        WaitSyncTask\InPos, sync8, tasklist;
        g_GripIn;
        WaitSyncTask\InPos, sync10, tasklist;
        WaitSyncTask\InPos, sync9, tasklist;
        MoveL passPoint20, v1000, z50, tool0;
        
        
        
        
               
        
        
        
        
        MoveL aboveWP20, v2500, fine, tool0;
        
        MoveL aboveWP30, v2500, fine, tool0;
        g_MoveTo 12;
        MoveL aboveWP40, v1000, fine, tool0;
        g_GripIn;
        MoveL aboveWP50, v100, fine, tool0;
        MoveL aboveWP60, v100, fine, tool0;
        MoveL aboveWP70, v100, fine, tool0;
        MoveL aboveWP80, v100, fine, tool0;
        MoveL aboveWP90, v100, fine, tool0;
        MoveL aboveWP100, v100, fine, tool0;
        MoveJ aboveWP110, v100, fine, tool0;
        MoveL aboveWP120, v100, fine, tool0;
        MoveL aboveWP130, v100, fine, tool0;
        MoveL aboveWP140, v100, fine, tool0;
        MoveL aboveWP150, v100, fine, tool0;
        MoveL aboveWP170, v100, fine, tool0;
        MoveL aboveWP180, v100, fine, tool0;
        MoveL aboveWP190, v100, fine, tool0;
        MoveL aboveWP200, v100, fine, tool0;
        MoveL aboveWP210, v100, fine, tool0;
        MoveL aboveWP220, v100, fine, tool0;
        MoveL aboveWP440, v100, fine, tool0;
        MoveL aboveWP450, v100, fine, tool0;
        MoveL aboveWP460, v100, fine, tool0;
        MoveL aboveWP450, v100, fine, tool0;
        MoveL aboveWP440, v100, fine, tool0;
        MoveL aboveWP220, v100, fine, tool0;
        g_MoveTo 4.1;
       
        MoveL aboveWP160, v10, fine, tool0;
        MoveL aboveWP230, v10, fine, tool0;
        g_GripIn;
        MoveL startPoint, v3000, fine, tool0;
        first_done := NOT first_done;
        build_second_floor;
    ENDPROC
    PROC startbuilding_second()
        MoveAbsJ photoPos\NoEOffs, v1000, z50, tool0;
        MoveAbsJ photoPos20\NoEOffs, v1000, z50, tool0;
        MoveJ passPoint10, v1000, z50, tool0;
        g_MoveTo 10;
        
        WaitSyncTask\InPos, sync7, tasklist;
        MoveL passPoint, v1000, z50, tool0;
        WaitSyncTask\InPos, sync8, tasklist;
        g_GripIn;
        WaitSyncTask\InPos, sync10, tasklist;
        WaitSyncTask\InPos, sync9, tasklist;
        MoveL passPoint20, v1000, z50, tool0;
        MoveL floor2, v2500, fine, tool0;
        MoveL floor12, v2500, fine, tool0;
        g_MoveTo 12;
        MoveL floor2, v1000, fine, tool0;
        g_GripIn;
        MoveL floor22, v100, fine, tool0;
        MoveL floor32, v200, fine, tool0;
        MoveL floor42, v100, fine, tool0;
        MoveL floor52, v100, fine, tool0;
        MoveL floor62, v100, fine, tool0;
        MoveL floor72, v100, fine, tool0;
        MoveJ floor82, v100, fine, tool0;
        MoveL floor92, v100, fine, tool0;
        MoveL floor102, v100, fine, tool0;
        MoveL floor112, v100, fine, tool0;
        MoveL floor122, v100, fine, tool0;
        MoveL floor132, v100, fine, tool0;
        MoveL floor142, v30, fine, tool0;
        MoveL floor152, v30, fine, tool0;
        MoveL floor162, v30, fine, tool0;
        MoveL floor172, v30, fine, tool0;
        MoveL floor182, v30, fine, tool0;
        MoveL floor192, v30, fine, tool0;
        g_MoveTo 4.2;
        MoveL floor212, v20, fine, tool0;
        MoveL floor202, v5, fine, tool0;
        MoveL floor212, v5, fine, tool0;
        MoveL floor222, v20, fine, tool0;
       
       
        
        
        
        
        MoveL startPoint, v3000, fine, tool0;
        second_done := NOT second_done;
        build_third_floor;
    ENDPROC
    PROC startbuilding_second_straight()
        
        MoveL floor2, v2500, fine, tool0;
        MoveL floor12, v2500, fine, tool0;
        g_MoveTo 12;
        
     MoveL floor2, v1000, fine, tool0;
        g_GripIn;
        MoveL floor22, v100, fine, tool0;
        MoveL floor32, v200, fine, tool0;
        MoveL floor42, v100, fine, tool0;
        MoveL floor52, v100, fine, tool0;
        MoveL floor62, v100, fine, tool0;
        MoveL floor72, v100, fine, tool0;
        MoveJ floor82, v100, fine, tool0;
        MoveL floor92, v100, fine, tool0;
        MoveL floor102, v100, fine, tool0;
        MoveL floor112, v100, fine, tool0;
        MoveL floor122, v100, fine, tool0;
        MoveL floor132, v100, fine, tool0;
        MoveL floor142, v30, fine, tool0;
        MoveL floor152, v30, fine, tool0;
        MoveL floor162, v30, fine, tool0;
        MoveL floor172, v30, fine, tool0;
        MoveL floor182, v30, fine, tool0;
        MoveL floor192, v30, fine, tool0;
        g_MoveTo 4.2;
        MoveL floor212, v20, fine, tool0;
        MoveL floor202, v5, fine, tool0;
        MoveL floor212, v5, fine, tool0;
        MoveL floor222, v20, fine, tool0;
       
       
        
        
        
        
        MoveL startPoint, v3000, fine, tool0;
        second_done := NOT second_done;
        build_third_floor;   
        
    ENDPROC
    PROC startbuilding_third()
        
         MoveAbsJ photoPos\NoEOffs, v1000, z50, tool0;
        MoveAbsJ photoPos20\NoEOffs, v1000, z50, tool0;
        MoveJ passPoint10, v1000, z50, tool0;
        g_MoveTo 10;
        
        WaitSyncTask\InPos, sync7, tasklist;
        MoveL passPoint, v1000, z50, tool0;
        WaitSyncTask\InPos, sync8, tasklist;
        g_GripIn;
        WaitSyncTask\InPos, sync10, tasklist;
        WaitSyncTask\InPos, sync9, tasklist;
        MoveL passPoint20, v1000, z50, tool0;
        
        MoveL aboveWP250, v2500, fine, tool0\WObj:=wobj0;
        MoveL aboveWP260, v2500, fine, tool0;
        g_MoveTo 15;
        MoveL aboveWP270, v2500, fine, tool0;
        g_GripIn;
        MoveL aboveWP280, v2500, fine, tool0;
        MoveL aboveWP290, v50, fine, tool0;
        MoveL aboveWP300, v50, fine, tool0;
        MoveL aboveWP290, v50, fine, tool0;
        MoveL aboveWP430, v50, fine, tool0;
        MoveL aboveWP310, v50, fine, tool0;
        MoveL aboveWP320, v50, fine, tool0;
        MoveL aboveWP330, v50, fine, tool0;
        MoveL aboveWP320, v50, fine, tool0;
        MoveL aboveWP310, v50, fine, tool0;
        MoveL aboveWP340, v50, fine, tool0;
        MoveL aboveWP350, v50, fine, tool0;
        MoveL aboveWP360, v50, fine, tool0;
        MoveL aboveWP350, v50, fine, tool0;
        MoveL aboveWP340, v50, fine, tool0;
        MoveL aboveWP370, v50, fine, tool0;
        MoveL aboveWP380, v50, fine, tool0;
        MoveL aboveWP390, v50, fine, tool0;
        MoveL aboveWP380, v50, fine, tool0;
        MoveL aboveWP370, v50, fine, tool0;
        MoveL aboveWP400, v50, fine, tool0;
        g_MoveTo 5.1;
        MoveL aboveWP420, v20, fine, tool0;
        MoveL aboveWP410, v50, fine, tool0;
        g_GripIn;
        
        Stop;
        
    ENDPROC
    PROC startbuilding_third_straight()
        MoveL aboveWP250, v2500, fine, tool0\WObj:=wobj0;
        MoveL aboveWP260, v2500, fine, tool0;
        g_MoveTo 15;
        MoveL aboveWP270, v2500, fine, tool0;
        g_GripIn;
        MoveL aboveWP280, v2500, fine, tool0;
        MoveL aboveWP290, v50, fine, tool0;
        MoveL aboveWP300, v50, fine, tool0;
        MoveL aboveWP290, v50, fine, tool0;
        MoveL aboveWP430, v50, fine, tool0;
        MoveL aboveWP310, v50, fine, tool0;
        MoveL aboveWP320, v50, fine, tool0;
        MoveL aboveWP330, v50, fine, tool0;
        MoveL aboveWP320, v50, fine, tool0;
        MoveL aboveWP310, v50, fine, tool0;
        MoveL aboveWP340, v50, fine, tool0;
        MoveL aboveWP350, v50, fine, tool0;
        MoveL aboveWP360, v50, fine, tool0;
        MoveL aboveWP350, v50, fine, tool0;
        MoveL aboveWP340, v50, fine, tool0;
        MoveL aboveWP370, v50, fine, tool0;
        MoveL aboveWP380, v50, fine, tool0;
        MoveL aboveWP390, v50, fine, tool0;
        MoveL aboveWP380, v50, fine, tool0;
        MoveL aboveWP370, v50, fine, tool0;
        MoveL aboveWP400, v50, fine, tool0;
        g_MoveTo 5.1;
        MoveL aboveWP420, v20, fine, tool0;
        MoveL aboveWP410, v50, fine, tool0;
        g_GripIn;
        
        Stop;
    ENDPROC
    PROC put_to_white_pos()
        MoveAbsJ photoPos\NoEOffs, v1000, z50, tool0;
        MoveAbsJ photoPos20\NoEOffs, v1000, z50, tool0;
        MoveJ passPoint10, v1000, z50, tool0;
        g_MoveTo 10;
        
        WaitSyncTask\InPos, sync7, tasklist;
        MoveL passPoint, v1000, z50, tool0;
        WaitSyncTask\InPos, sync8, tasklist;
        g_GripIn;
        WaitSyncTask\InPos, sync10, tasklist;
        WaitSyncTask\InPos, sync9, tasklist;
        MoveL passPoint20, v1000, z50, tool0;
        MoveL passPoint30, v1000, z50, tool0;
        MoveL passPoint50, v1000, z50, tool0;
        MoveL passPoint60, v1000, fine, tool0;
            g_MoveTo 10;
            MoveL passPoint50, v1000, z50, tool0;
        white_in_place :=not white_in_place;
         IF first_done THEN
            build_second_floor;
        ELSEIF not first_done THEN
        build_first_floor;
        ELSEIF first_done and second_done THEN
            build_third_floor;
         ENDIF
    ENDPROC
	PROC put_to_red_pos()
        MoveAbsJ photoPos\NoEOffs, v1000, z50, tool0;
        MoveAbsJ photoPos20\NoEOffs, v1000, z50, tool0;
        MoveJ passPoint10, v1000, z50, tool0;
        g_MoveTo 10;
        
        WaitSyncTask\InPos, sync7, tasklist;
        MoveL passPoint, v1000, z50, tool0;
        WaitSyncTask\InPos, sync8, tasklist;
        g_GripIn;
        WaitSyncTask\InPos, sync10, tasklist;
        WaitSyncTask\InPos, sync9, tasklist;
        MoveL passPoint20, v1000, z50, tool0;
        MoveL passPoint30, v1000, z50, tool0;
        MoveL passPoint70, v1000, z50, tool0;
        MoveL passPoint80, v1000, fine, tool0;
            g_MoveTo 10;
            MoveL passPoint70, v1000, z50, tool0;
        red_in_place :=not red_in_place;
         IF first_done THEN
            build_second_floor;
        ELSEIF not first_done THEN
        build_first_floor;
        ELSEIF first_done and second_done THEN
            build_third_floor;
         ENDIF
    ENDPROC
    PROC put_to_blue_pos()
     
        MoveAbsJ photoPos\NoEOffs, v1000, z50, tool0;
        MoveAbsJ photoPos20\NoEOffs, v1000, z50, tool0;
        MoveJ passPoint10, v1000, z50, tool0;
        g_MoveTo 10;
        
        WaitSyncTask\InPos, sync7, tasklist;
        MoveL passPoint, v1000, z50, tool0;
        WaitSyncTask\InPos, sync8, tasklist;
        g_GripIn;
        WaitSyncTask\InPos, sync10, tasklist;
        WaitSyncTask\InPos, sync9, tasklist;
        MoveL passPoint20, v1000, z50, tool0;
        MoveL passPoint30, v1000, z50, tool0;
        MoveL passPoint40, v1000, z50, tool0;
        MoveL at_blue_piece, v100, fine, tool0;
            g_MoveTo 10;
        MoveL above_blue_piece, v1000, z50, tool0; 
        blue_in_place :=not blue_in_place;
        build_first_floor;
        
    ENDPROC
    PROC put_to_green_pos()
        MoveAbsJ photoPos\NoEOffs, v1000, z50, tool0;
        MoveAbsJ photoPos20\NoEOffs, v1000, z50, tool0;
        MoveJ passPoint10, v1000, z50, tool0;
        g_MoveTo 10;
        
        WaitSyncTask\InPos, sync7, tasklist;
        MoveL passPoint, v1000, z50, tool0;
        WaitSyncTask\InPos, sync8, tasklist;
        g_GripIn;
        WaitSyncTask\InPos, sync10, tasklist;
        WaitSyncTask\InPos, sync9, tasklist;
        MoveL passPoint20, v1000, z50, tool0;
        MoveL passPoint30, v1000, z50, tool0;
        MoveL above_green_piece, v1000, z50, tool0;
        MoveL at_green_piece, v100, fine, tool0;
            g_MoveTo 10;
            MoveL above_green_piece, v1000, z50, tool0;
        green_in_place :=not green_in_place;
        IF first_done THEN
            build_second_floor;
        ELSEIF not first_done THEN
        build_first_floor;
        
        ENDIF
       
    ENDPROC
 	
      
ENDMODULE