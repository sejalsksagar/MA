;Write 8086 ALP to interface DAC and generate following waveforms on oscilloscope

;a) SAWTOOTH WAVEFORM

    ;configure 8255
    MOV AL, 80H
    OUT 67H, AL ;CW
    
    ;PB0 = 1
    MOV AL, 01H  
    OUT 63H, AL 
    
INIT:
    MOV AL, 00H
    
INC_LOOP:
    OUT 61H, AL
    INC AL
    CMP AL, FFH
    JNE INC_LOOP
    
    OUT 61H, AL
    JMP INIT
    
    
;b) RAMP WAVEFORM

    ;configure 8255
    MOV AL, 80H
    OUT 67H, AL ;CW
    
    ;PB0 = 1
    MOV AL, 01H  
    OUT 63H, AL  
    
INIT:
    MOV AL, FFH
    
DEC_LOOP:
    OUT 61H, AL
    DEC AL
    CMP AL, 00H
    JNE DEC_LOOP
    
    OUT 61H, AL
    JMP INIT
    
    
;c) STAIRCASE WAVEFORM

    ;configure 8255
    MOV AL, 80H
    OUT 67H, AL ;CW
    
    ;PB0 = 1
    MOV AL, 01H  
    OUT 63H, AL  
    
INIT:
    MOV AL, 00H
    
STEP_UP:
    OUT 61H, AL
    ADD AL, 40H ;4 steps >> stepsize = 256/4 = 64 = 40H
    CALL 7001   ;delay
    CMP AL, FFH
    JNE STEP_UP
    
    OUT 61H, AL
    JMP INIT
