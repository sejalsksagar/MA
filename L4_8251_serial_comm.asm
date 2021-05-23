;MA Lab #4 22/05/21
;Write 8086 ALP to program 8251 for serial communication between two 8251s.

;Mode Instruction Format for asyn mode  
;CW: 0100 1101 = 4DH

;30H - Data & 31H - Control = Upper 8251
;38H - Data & 39H - Control = Lower 8251

;Command Instruction
;0001 0001 = 11H Tx
;0011 0110 = 36H Rx


  MOV AL, 4H ;Initialize both 8251 mode instruction format
  OUT 31, AL
  OUT 39, AL
  MOV AL, 11 ;Initialize upper 8251 as Transmitter
  OUT 31, AL
  MOV AL, 36 ;Initialize lower 8251 as Receiver
  OUT 39, AL
  MOV SI, 3000 ;Source location of data
  MOV BX, 4000 ;Destination location
  MOV CL, 05 ;Counter

UP:
  IN AL, 31 ;Check whether transmitter is ready
  AND AL, 01 
  JZ UP
  
  MOV AL, [SI] ;Read data ffrom source & load to 8251 TX
  OUT 30, AL

UP1:
  IN AL, 39 ;Check whether Rx is ready
  AND AL, 02
  JZ UP1
  
  IN AL, 38 ;Read data from Rx & store at Destination
  MOV [BX], AL
  INC SI ;Go to next data
  INC BX
  DEC CL
  JNZ UP
  INT 3 ;End of program
  
  
