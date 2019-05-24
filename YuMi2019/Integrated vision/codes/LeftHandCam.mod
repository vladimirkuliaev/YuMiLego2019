MODULE MainModule
	CONST robtarget safePoint:=[[194.64,287.75,197.42],[0.0735244,0.843246,-0.113842,0.520163],[0,1,-1,4],[102.588,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget safePoint10:=[[266.62,149.09,62.15],[0.495985,0.508823,-0.500331,0.49474],[-1,1,-1,4],[107.346,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget readyToOpen:=[[266.62,149.08,62.15],[0.495987,0.508822,-0.50033,0.494739],[-1,1,-1,4],[107.346,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget readyToOpen10:=[[254.87,69.02,59.07],[0.496019,0.508794,-0.500334,0.494732],[-1,1,-1,4],[108.541,9E+09,9E+09,9E+09,9E+09,9E+09]];
    
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
    VAR bool ready :=FALSE; 
    
    PERS tasks tasklist{2}:=[["T_ROB_L"], ["T_ROB_R"]];
	CONST jointtarget photoPos:=[[-83.0377,-142.241,15.6685,81.9131,72.8104,-152.786],[70.0473,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget readyToOpen20:=[[254.87,244.32,59.07],[0.496027,0.508793,-0.500331,0.494728],[-1,1,-1,4],[108.541,9E+09,9E+09,9E+09,9E+09,9E+09]];
	PROC main()
        preparation;
        Stop;
        Hand_SetHoldForce(12);
        WHILE NOT ready
        DO
            check_operation;
            
        ENDWHILE
        
        
		
		
        
        
	ENDPROC
    PROC preparation()
        g_JogOut;
		g_SetForce 5;
		g_SetMaxSpd 3;
		g_JogIn;
		g_Calibrate;
		g_GripIn;
    ENDPROC
    
    PROC check_operation()
        MoveL safePoint, v1000, fine, tool0;
        
                WaitSyncTask\InPos, sync1, tasklist;
        
		MoveL readyToOpen, v1000, fine, tool0;
		
		g_MoveTo 10;
        
                WaitSyncTask\InPos, sync2, tasklist;
        
		MoveL readyToOpen10, v30, fine, tool0;
                WaitSyncTask\InPos, sync3, tasklist;
		g_GripIn;
        
                WaitSyncTask\InPos, sync4, tasklist;
        
                WaitSyncTask\InPos, sync5, tasklist;
        MoveAbsJ photoPos\NoEOffs, v50, fine, tool0;
        
                WaitSyncTask\InPos, sync6, tasklist;
                MoveJ readyToOpen10, v50, fine, tool0;
        WaitSyncTask\InPos, sync7, tasklist;
       WaitSyncTask\InPos, sync8, tasklist;
       WaitSyncTask\InPos, sync10, tasklist;
       g_JogOut;
       MoveL readyToOpen20, v50, fine, tool0;
       WaitSyncTask\InPos, sync9, tasklist;
        
        
    
    
        
    ENDPROC
ENDMODULE