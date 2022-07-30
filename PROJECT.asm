;THE PASSWORD IS "5229" :D
.MODEL SMALL                                                         
.DATA                                                                    
.STACK                                                                       
WARNING   DB 10,13,10,13, ' WELCOME ,, HINT IF YOU ENTERED AN INVALID PASSWORD FOR THREE TIMES  ','$'
WARNING1  DB 10,13,10,13, '   YOU WILL HAVE TO WAIT FOR TEN SECONDS TO TRY AGAIN','$'                                                                   
BEGIN     DB 10,13,10,13, ' PLEASE ENTER THE PASSWORD: ','$'             
INPUT     DB 100 DUP(0),                                           '$'   
ASTRC     DB '*',                                                  '$'   
SPACE     DB 08,          ' ',                                     '$'   
PASSED    DB 10,13,10,13, ' YOU ARE SIGNED IN    :)',              '$'   
INVALID   DB 10,13,10,13, ' INVALID PASSWORD !!! ',                '$'   
HINT      DB 10,13,10,13, ' YOU HAVE ENTERED THE PASSWORD WRONG FOR THREE TIMES .... ','$'
HINT1     DB 10,13,10,13, '   PLEASE WAIT FOR 10 SECONDS TO TRY AGAIN !! :  ','$'
STOPWATCH DB '9$'
EXCEED    DB 10,13,10,13, ' WES3ET MENAK AWY DE XD ',              '$'   
RETRY     DB 10,13,10,13, ' PLEASE RE-INTER THE PASSWORD:  ',      '$' 
BACKSPACE DB 08,'$' 
LOGOFF    DB 10,13,10,13,  ' IF YOU WANT TO SWITCH OFF THE DEVICE PRESS [0] BUTTON : ','$' 
.CODE                                              
    START:                                                              	
	          MOV AX,@DATA                                              
			  MOV DS,AX                                                 
			  MOV DI,00H
			  MOV AH,09H
			  LEA DX, WARNING
			  INT 21H
              MOV AH,09H
              LEA DX,WARNING1
              INT 21H			  
			  MOV CX,200
			  CALL DELAY
			  CALL CLEAR 
			  MOV AH,09H                                          
			  LEA DX,BEGIN                                        
			  INT 21H                                                    
			  JMP TEMP                                                  	
	FAILED:                                                              
              MOV AH,09H                                                
              LEA DX,INVALID                                            
              INT 21H                                                   
			  CALL COUNT
			  CALL DELAY
			  INC DI
			  CMP DI,03H			  
			  JZ  WAIT1
			  CALL COUNT                                               
			  CALL DELAY                                                
	NEW:		  
	          CALL CLEAR                                                 			  
	TRY:	  
              MOV AH,09H	
	          LEA DX,RETRY
			  INT 21H
	TEMP:                                                                           
	          MOV CX,20                                                
			  MOV BX,0H                                                 
	USER:                                                                                                  
              MOV AH,07H                                                
              INT 21H             
              CMP AL,13                                                
              JZ CHECK                                                  
              CALL ERASE                                               
    COMPLETE:                                                             
	          MOV INPUT[BX],AL	                                                          	  
   	          INC BX                                                     
			  MOV AH,09H
			  LEA DX,ASTRC
			  INT 21H
              LOOP USER                                                  
	EXCESS:	                                                            	  
			  CALL COUNT                                                
			  CALL DELAY
			  MOV AH,09H
			  LEA DX,EXCEED
			  INT 21H
			  CALL COUNT 
			  CALL DELAY 
    CHECK:                                                               
              CMP BX,4H                                                 
              JNZ FAILED                                                
			  CMP INPUT[0],'5'                                           
			  JNZ FAILED
			  CMP INPUT[1],'2'
			  JNZ FAILED
			  CMP INPUT[2],'2'
			  JNZ FAILED
			  CMP INPUT[3],'9'
			  JNZ FAILED
			  CALL SUCCESS
              CALL CLEAR 			  
			  JMP SIGNOUT                                            
    ERASE:                                                            
	          CMP AL,08                                              
              JNZ COMPLETE                                            
    DELETE:                                                            
              DEC BX                                                   
              MOV INPUT[BX],08                                         
              MOV AH,09H
              LEA DX,SPACE 
              INT 21H 
              MOV AH,02H                                              
              MOV DL,08                                                
              INT 21H
              MOV AH,07H                                               
              INT 21H 
              CMP AL,13                                               
              JZ CHECK                                                 
              CMP AL,08                                               
              JZ DELETE                                               
              RET                                                        	
              ENDP ERASE                                                
    WAIT1:  
	          CALL CLEAR 
              MOV AH,09H
              LEA DX,HINT
              INT 21H 
			  MOV AH,09H
			  LEA DX, HINT1
			  INT 21H
			  MOV BP,0
			  MOV STOPWATCH,'9'
	TOP:
			  MOV AH,2CH
			  INT 21H 
			  MOV BH,DH
	GETSEC:	
		      MOV AH,2CH
		      INT 21H
		      CMP BH,DH
		      JNE PRINTA
		      JMP GETSEC
    PRINTA:	
    	      MOV AH,9
    	      LEA DX,STOPWATCH
    	      INT 21H 
    	      MOV AH,9
    	      LEA DX,BACKSPACE
    	      INT 21H
    	      SUB STOPWATCH,1
    	      INC BP
    	      CMP BP,10
    	      JE  LOL 
    	      JMP TOP   
	LOL:	  
	          MOV DI,0
              JMP  NEW
               			  
	SUCCESS:                                                           
              MOV AH,09H
              LEA DX,PASSED 
              INT 21H
			  CALL COUNT
			  CALL DELAY 
              RET
              ENDP SUCCESS 			  
	COUNT:	                                                           	  
	          MOV CX,50
			  RET
              ENDP COUNT			  
	DELAY:                                                                		  
	          NOP                                                       
			  NOP
			  NOP
			  NOP
			  LOOP DELAY                                                
			  RET
			  ENDP DELAY
    CLEAR:                                                                 
	          MOV AX,03H                                                
			  INT 10H
			  RET
              ENDP CLEAR    			  
    SIGNOUT:
	          MOV AH,09H
			  LEA DX,LOGOFF
              INT 21H
    INPUT1:          
              MOV AH,07H                                                
              INT 21H
			  CMP AL,30H
			  JNZ INPUT1
	TERMINATE:             	
           	  MOV AH, 4CH                                              
           	  INT 21H
CODE ENDS                                                              
.EXIT                                                                  
END                                                                     	
			  
			  
			  
              			  
			  
		 
         	  
			  
              			  
			  
			  
			  
              			  
			  
		 
             
        
       
       
        
        
    
        





