;MA LAB #3 22/05/21
;Write 8086 ALP to program 8253 to observe outputs of different modes using counter display.

;MODE 0 COUNTER 0
;Mode 0 - Interrupt on Terminal Count
;Counter value = 0005
;CW: 0011 0000 = 30H for Counter

MOV AL, 30 ;Initialize 8253 for Counter 0, Mode 0
OUT 33, AL
MOV AL, 05 ;Load lower byte of count
OUT 30, AL
MOV AL, 00 ;load higher byte of count
OUT 30, AL

UP:
  MOV AL, 00 ;Latch the count value
  OUT 33, AL
  IN AL, 30 ;Read lower byte of count
  MOV CH, AL
  IN AL, 30 ;Read higher byte of count
  MOV AH, AL ;Load value in AX register
  MOV AL, CH
  CALL F000:01AC ;Display AX on LED display - Data section-right 4
  JMP UP
