MODULE MainModule
    VAR socketdev serverSocket;
    VAR socketdev clientSocket;

    VAR string data;

    VAR string start;
    VAR string stopcheck;
    VAR bool okX;
    VAR bool okY;
    VAR bool okZ;
    VAR bool okid;
    VAR num foundx;
    VAR num foundxend;
    VAR num xlength;
    VAR num foundy;
    VAR num foundyend;
    VAR num ylength;
    VAR num foundz;
    VAR num foundzend;
    VAR num zlength;
    VAR num findid;
    VAR num findrot;
    VAR num findsp;
    VAR num idlength;
    VAR num rotlength;
    VAR num tryX;
    VAR num tryY;
    VAR num tryZ;
    VAR num wpID;

    VAR string rotinfo;
    VAR string partx;
    VAR string party;
    VAR string partz;

    VAR string nameWP;
    VAR string rotation;
    VAR string partID;

    VAR bool dummy:=FALSE;

    VAR bool rotreq:=FALSE;

    PERS wobjdata wobj1:=[FALSE,TRUE,"",[[402.123,-85.4556,45.7888],[0.714337,0.00384811,-0.00185838,-0.699789]],[[0,0,0],[1,0,0,0]]];

    CONST robtarget aboveSquare:=[[392.82,84.68,85.85],[0.008429,0.720698,0.693198,0.000710105],[1,-2,2,4],[-157.745,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget atSquare:=[[392.82,84.68,46.20],[0.00843173,0.720699,0.693197,0.000710762],[1,-2,2,4],[-157.745,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget aboveRect3:=[[390.39,123.44,88.20],[0.0129949,0.702215,0.711759,0.0111123],[1,-2,2,4],[-157.585,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget atRect3:=[[390.39,123.44,47.84],[0.0129977,0.702214,0.71176,0.0111121],[1,-2,2,4],[-157.585,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget atRect8:=[[391.14,172.92,45.46],[0.0128495,0.708706,0.70537,0.00485425],[2,-2,2,4],[-158.649,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget aboveRect8:=[[391.14,172.92,84.90],[0.0128481,0.708706,0.70537,0.00485415],[1,-2,2,4],[-158.649,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget atRect7:=[[425.86,172.54,47.86],[0.0128518,0.708709,0.705368,0.00482815],[2,-2,2,4],[-158.652,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget aboveRect7:=[[423.27,172.56,88.78],[0.0128498,0.708707,0.705369,0.00485353],[2,-2,2,4],[-158.652,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget atRect6:=[[452.98,172.55,48.75],[0.0128577,0.708712,0.705364,0.00483975],[2,-2,2,4],[-158.657,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget aboveRect6:=[[455.40,172.56,90.45],[0.0128522,0.70871,0.705367,0.0048541],[2,-2,2,4],[-158.656,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget atRect9:=[[359.26,172.53,45.95],[0.012845,0.708706,0.70537,0.00481702],[1,-2,2,4],[-158.656,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget aboveRect9:=[[359.75,172.57,93.39],[0.0128469,0.708708,0.705369,0.00485374],[1,-2,2,4],[-158.656,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget atRect10:=[[325.50,172.57,45.66],[0.0128436,0.708708,0.705368,0.00484549],[1,-2,2,4],[-158.655,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget aboveRect10:=[[327.54,172.57,91.06],[0.0128477,0.708708,0.705369,0.00485525],[1,-2,2,4],[-158.655,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget atRect5:=[[327.49,124.36,46.05],[0.0128455,0.708708,0.705368,0.00485574],[1,-2,2,4],[-158.65,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget aboveRect5:=[[327.49,124.36,89.91],[0.0128451,0.708708,0.705369,0.00485555],[1,-2,2,4],[-158.65,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget atRect4:=[[358.18,124.35,46.47],[0.012843,0.708709,0.705367,0.00484029],[1,-2,2,4],[-158.647,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget aboveRect4:=[[359.41,124.36,87.84],[0.0128455,0.708709,0.705367,0.00485432],[1,-2,2,4],[-158.647,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget atRect2:=[[423.36,124.36,47.83],[0.0128491,0.708709,0.705367,0.00485238],[1,-2,2,4],[-158.648,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget aboveRect2:=[[423.36,124.36,95.78],[0.0128489,0.708712,0.705364,0.00485348],[1,-2,2,4],[-158.647,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget atRect1:=[[455.30,124.36,48.38],[0.0128577,0.708716,0.70536,0.00485569],[2,-2,2,4],[-158.647,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget aboveRect1:=[[455.29,124.37,107.15],[0.0128557,0.708719,0.705357,0.00485413],[1,-2,2,4],[-158.647,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget safepos:=[[-85.23,-112.11,194.62],[0.0451027,-0.414455,-0.908361,0.0327424],[1,-2,3,4],[-176.223,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST jointtarget home:=[[0,-130,30,0,40,0],[-135,9E+09,9E+09,9E+09,9E+09,9E+09]];
    
    VAR robtarget trytarget;
    VAR robtarget trytarget2;
    VAR robtarget pushtarget;
    VAR robtarget pushtarget2;
    VAR robtarget abovetargetrot;

    VAR orient rotresta:=[0.00860358,-0.694976,0.718946,0.00714151];
    VAR confdata rotrestb:=[1,-2,1,4];
    VAR extjoint rotrestc:=[-146.79,9E+09,9E+09,9E+09,9E+09,9E+09];

    PROC main()





        Hand_SetHoldForce(12);





        Calibration;
        Initialization;





        WHILE dummy DO

            SocketCreate serverSocket;
            SocketBind serverSocket,"192.168.125.1",4000;
            SocketListen serverSocket;
            SocketAccept serverSocket,clientSocket,\Time:=WAIT_MAX;
            SocketReceive clientSocket\Str:=data;

            stopcheck:=StrPart(data,1,4);
            IF stopcheck="Stop" THEN
                dummy:=FALSE;
                MoveAbsJ home\NoEOffs,v7000,fine,tool0\WObj:=wobj0;
                SendConfirmation;
            ELSE

                !Read rotation info

                !Get the ID number 

                findid:=StrFind(data,1,STR_DIGIT);
                findsp:=StrFind(data,1,";");
                idlength:=findsp-findid;
                partID:=StrPart(data,findid,idlength);
                okid:=StrToVal(partID,wpID);


                findrot:=StrFind(data,findsp+1,";");
                rotlength:=findrot-(findsp+1);
                rotation:=StrPart(data,findsp+1,rotlength);
                IF rotation="90" THEN
                    rotreq:=TRUE;
                ELSEIF rotation="00" THEN
                    rotreq:=FALSE;
                ENDIF




                !Get the ID number

                findid:=StrFind(data,1,STR_DIGIT);
                findsp:=StrFind(data,1,";");
                idlength:=findsp-findid;
                partID:=StrPart(data,findid,idlength);
                okid:=StrToVal(partID,wpID);
                nameWP:=StrPart(data,1,findid-1);
                IF nameWP="Square" THEN
                    MoveJ aboveSquare,vmax,fine,tool0;
                    g_MoveTo 19.7;
                    MoveL atSquare,vmax,fine,tool0;
                    g_JogIn;
                    MoveL aboveSquare,vmax,fine,tool0;
                ELSEIF nameWP="Rectan" THEN
                    IF wpID=1 THEN
                        !go to square1
                        MoveJ aboveRect1,vmax,fine,tool0;
                        g_MoveTo 19.7;
                        MoveL atRect1,vmax,fine,tool0;
                        g_GripIn;
                        MoveJ aboveRect1,vmax,fine,tool0;
                    ELSEIF wpID=2 THEN
                        !go to square2
                        MoveJ aboveRect2,vmax,fine,tool0;
                        g_MoveTo 19.7;
                        MoveL atRect2,vmax,fine,tool0;
                        g_GripIn;
                        MoveJ aboveRect2,vmax,fine,tool0;
                    ELSEIF wpID=3 THEN
                        MoveJ aboveRect3,v1000,fine,tool0;
                        g_MoveTo 19.7;
                        MoveL atRect3,v100,fine,tool0;
                        g_GripIn;
                        MoveJ aboveRect3,v1000,fine,tool0;
                    ELSEIF wpID=4 THEN
                        !go to square4
                        MoveJ aboveRect4,vmax,fine,tool0;
                        g_MoveTo 19.7;
                        MoveL atRect4,vmax,fine,tool0;
                        g_GripIn;
                        MoveJ aboveRect4,vmax,fine,tool0;
                    ELSEIF wpID=5 THEN
                        !go to square5
                        MoveJ aboveRect5,vmax,fine,tool0;
                        g_MoveTo 19.7;
                        MoveL atRect5,vmax,fine,tool0;
                        g_GripIn;
                        MoveJ aboveRect5,vmax,fine,tool0;
                    ELSEIF wpID=6 THEN
                        !go to square6
                        MoveJ aboveRect6,vmax,fine,tool0;
                        g_MoveTo 19.7;
                        MoveL atRect6,vmax,fine,tool0;
                        g_GripIn;
                        MoveJ aboveRect6,vmax,fine,tool0;
                    ELSEIF wpID=7 THEN 
                        !go to square7
                        MoveJ aboveRect7,vmax,fine,tool0;
                        g_MoveTo 19.7;
                        MoveL atRect7,vmax,fine,tool0;
                        g_GripIn;
                        MoveJ aboveRect7,vmax,fine,tool0;
                    ELSEIF wpID=8 THEN
                        !go to square8
                        MoveJ aboveRect8,vmax,fine,tool0;
                        g_MoveTo 19.7;
                        MoveL atRect8,vmax,fine,tool0;
                        g_GripIn;
                        MoveJ aboveRect8,vmax,fine,tool0;
                    ELSEIF wpID=9 THEN
                        !go to square9
                        MoveJ aboveRect9,vmax,fine,tool0;
                        g_MoveTo 19.7;
                        MoveL atRect9,vmax,fine,tool0;
                        g_GripIn;
                        MoveJ aboveRect9,vmax,fine,tool0;
                    ELSEIF wpID=10 THEN
                        !go to square10
                        MoveJ aboveRect10,vmax,fine,tool0;
                        g_MoveTo 19.7;
                        MoveL atRect10,vmax,fine,tool0;
                        g_GripIn;
                        MoveJ aboveRect10,vmax,fine,tool0;
                    ENDIF



                ENDIF



                foundx:=StrFind(data,1,"(");
                foundxend:=StrFind(data,1,",");
                xlength:=foundxend-(foundx+1);
                partx:=StrPart(data,foundx+1,xlength);
                okX:=StrToVal(partx,tryX);
                foundz:=StrFind(data,foundxend+1,",");

                zlength:=foundz-(foundxend+1);
                partz:=StrPart(data,foundxend+1,zlength);
                okZ:=StrToVal(partz,tryZ);
                foundy:=StrFind(data,foundz+1,")");
                ylength:=foundy-(foundz+1);
                party:=StrPart(data,foundz+1,ylength);
                okY:=StrToVal(party,tryY);

                trytarget:=[[tryX*24,tryY*24,tryZ*24+30],[0.00702104,-0.00906265,-0.999928,0.00352561],[1,-2,2,4],[-145.573,9E+09,9E+09,9E+09,9E+09,9E+09]];




                MoveJ safepos,vmax,fine,tool0\WObj:=wobj1;

                MoveJ trytarget,vmax,fine,tool0,\Wobj:=wobj1;

                IF rotreq=TRUE THEN
                    !apply rotation of the last joint
                    abovetargetrot:=[[tryX*24,tryY*24,tryZ*24+30],rotresta,rotrestb,rotrestc];
                    MoveJ abovetargetrot,vmax,fine,tool0\WObj:=wobj1;

                    trytarget2:=[[tryX*24-1.6,tryY*24,tryZ*24+2.5],rotresta,rotrestb,rotrestc];
                    MoveL trytarget2,v100,fine,tool0\WObj:=wobj1;

                    g_GripOut;

                    MoveL abovetargetrot,vmax,fine,tool0\WObj:=wobj1;


                    FOR i FROM 1 TO 2 DO
                        pushtarget:=[[tryX*24,tryY*24+5.44,tryZ*24+20],[0.00707566,0.000428977,-0.999969,0.00344461],[1,-2,1,4],[-105.113,9E+09,9E+09,9E+09,9E+09,9E+09]];

                        MoveL pushtarget,v100,fine,tool0,\Wobj:=wobj1;

                        g_MoveTo 1;
                        pushtarget2:=[[tryX*24,tryY*24+5.44,tryZ*24+7.64],[0.00707566,0.000428977,-0.999969,0.00344461],[1,-2,1,4],[-105.113,9E+09,9E+09,9E+09,9E+09,9E+09]];
                        MoveL pushtarget2,v10,fine,tool0,\Wobj:=wobj1;
                        MoveL pushtarget,v100,fine,tool0,\Wobj:=wobj1;
                        pushtarget2:=[[tryX*24,tryY*24+5.44-10,tryZ*24+7.64],[0.00707566,0.000428977,-0.999969,0.00344461],[1,-2,1,4],[-105.113,9E+09,9E+09,9E+09,9E+09,9E+09]];
                        MoveL pushtarget2,v10,fine,tool0,\Wobj:=wobj1;
                        MoveL pushtarget,v100,fine,tool0,\Wobj:=wobj1;
                        pushtarget2:=[[tryX*24,tryY*24+5.44+10,tryZ*24+7.64],[0.00707566,0.000428977,-0.999969,0.00344461],[1,-2,1,4],[-105.113,9E+09,9E+09,9E+09,9E+09,9E+09]];
                        MoveL pushtarget2,v10,fine,tool0,\Wobj:=wobj1;
                        MoveL pushtarget,v100,fine,tool0,\Wobj:=wobj1;
                    ENDFOR
                    MoveJ safepos,vmax,fine,tool0\WObj:=wobj1;
                ELSE
                    !just continue

                    trytarget2:=[[tryX*24+1,tryY*24+2,tryZ*24+1.5],[0.00702104,-0.00906265,-0.999928,0.00352561],[1,-2,2,4],[-145.573,9E+09,9E+09,9E+09,9E+09,9E+09]];
                    MoveL trytarget2,v100,fine,tool0\WObj:=wobj1;


                    g_MoveTo 19.7;

                    MoveL trytarget,vmax,fine,tool0,\Wobj:=wobj1;
                    FOR i FROM 1 TO 2 DO
                        pushtarget:=[[tryX*24,tryY*24,tryZ*24+20],[0.00209069,-0.727174,-0.686409,0.00744442],[1,-2,2,4],[-98.2663,9E+09,9E+09,9E+09,9E+09,9E+09]];

                        MoveL pushtarget,v100,fine,tool0,\Wobj:=wobj1;
                        g_MoveTo 1;
                        pushtarget2:=[[tryX*24,tryY*24+1,tryZ*24+7.64],[0.00209069,-0.727174,-0.686409,0.00744442],[1,-2,2,4],[-98.2663,9E+09,9E+09,9E+09,9E+09,9E+09]];
                        MoveL pushtarget2,v10,fine,tool0,\Wobj:=wobj1;
                        MoveL pushtarget,v100,fine,tool0,\Wobj:=wobj1;
                        pushtarget2:=[[tryX*24+7,tryY*24+1,tryZ*24+7.64],[0.00209069,-0.727174,-0.686409,0.00744442],[1,-2,2,4],[-98.2663,9E+09,9E+09,9E+09,9E+09,9E+09]];
                        MoveL pushtarget2,v10,fine,tool0,\Wobj:=wobj1;
                        MoveL pushtarget,v100,fine,tool0,\Wobj:=wobj1;
                        pushtarget2:=[[tryX*24-7,tryY*24+1,tryZ*24+7.64],[0.00209069,-0.727174,-0.686409,0.00744442],[1,-2,2,4],[-98.2663,9E+09,9E+09,9E+09,9E+09,9E+09]];
                        MoveL pushtarget2,v10,fine,tool0,\Wobj:=wobj1;
                        MoveL pushtarget,v100,fine,tool0,\Wobj:=wobj1;


                    ENDFOR
                    MoveJ safepos,vmax,fine,tool0\WObj:=wobj1;
                ENDIF

                SendConfirmation;


            ENDIF
        ENDWHILE





    ERROR
        IF ERRNO=ERR_SOCK_TIMEOUT THEN
            RETRY;

        ELSEIF ERRNO=ERR_SOCK_CLOSED THEN
            SocketClose clientSocket;
            SocketClose serverSocket;
            SocketCreate serverSocket;
            SocketBind serverSocket,"192.168.125.1",4000;
            SocketListen serverSocket;

            SocketAccept serverSocket,clientSocket,\Time:=WAIT_MAX;

            RETRY;





        ENDIF
    ENDPROC


    PROC Calibration()
        g_SetForce 5;
        g_SetMaxSpd 10;
        g_JogOut;
        g_JogIn;
        g_Calibrate;
        g_JogIn;
    ENDPROC

    PROC Initialization()
        SocketCreate serverSocket;
        SocketBind serverSocket,"192.168.125.1",4000;
        SocketListen serverSocket;
        SocketAccept serverSocket,clientSocket,\Time:=WAIT_MAX;
        SocketReceive clientSocket\Str:=data;
        start:=StrPart(data,1,5);
        IF start="Start" THEN

            dummy:=TRUE;
            MoveJ safepos,vmax,fine,tool0\WObj:=wobj1;
        ELSE
            dummy:=FALSE;
        ENDIF

        SendConfirmation;
    ENDPROC

    PROC SendConfirmation()

        SocketSend clientSocket\Str:="received ";
        SocketClose clientSocket;
        SocketClose serverSocket;
    ENDPROC



ENDMODULE