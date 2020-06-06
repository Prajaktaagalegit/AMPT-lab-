; This is a Boot Loader Program which prints a message...

[BITS 16]             
[ORG 0x7C00]   	

; INITIALIZING: 
	
MOV SI, data               	
CALL _ModeV
CALL _Pos_cur
CALL _String              
JMP $                        


; Functions: 

; Indicate Video Mode
_ModeV:
        MOV AH,0X00
        MOV AL,0X13
        INT 0X10
        RET

;Setting to current Position:
_Pos_cur:
        MOV AH,0x02     
        MOV BH,0x00      
        MOV DH,0x06      
        MOV DL,0x00      
        INT 0x10         
        RET              


;Printing code to print charcter on screen
_Print_Char:         	
                        
        MOV AH, 0x0E     
        MOV BH, 0x00    
        MOV BL, 0x07    
        INT 0x10        
        RET             


_String:
fet_char:          
        MOV AL, [SI]    
        INC SI               
        OR AL, AL            
        JZ over        
        CALL _Print_Char  
        JMP fet_char     
	over:     
        RET   

; Printing the Message
          
data db 'AMPT Assignment 1', 0


; Fill rest of sector to 0

TIMES 510 - ($ - $$) db 0   
DW 0xAA55 








