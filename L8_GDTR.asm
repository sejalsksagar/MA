;MA LAB #8 28/05/2021
;2372 SEJAL KSHIRSAGAR
;Write ALP for to read GDTR/LDTR and IDTR
;and display the table content pointed by
;GDTR and IDTR.

%macro print 2
	mov eax,4
	mov ebx,1
	mov ecx,%1
	mov edx,%2
	int 80h
%endmacro

SECTION .data
	msg1 	db "GDTR = "
	msg1len equ $-msg1
	msg2 	db "IDTR = "
	msg2len equ $-msg2
	msg3 	db "Program to read and display the contents of GDTR & IDTR!",0ah
	msg3len equ $-msg3
	msg4 	db "LDTR = "
	msg4len equ $-msg4
	nl	db 0Ah
	err1 db "Sorry cannot get GDTR & IDTR!!!"
	err1len equ $-err1	
	colon db ':'	
	newln db 0ah
	
SECTION .bss
	GDTRl: 	resw 1	;1 word -> 2 bytes -> 4 nibbles -> 16 bits
	GDTRb: 	resd 1  ;4 bytes
	IDTRl:  resw 1
	IDTRb:  resd 1
	LDTR:   resw 1
	digits: resb 8
	desc:	resq 1
	
SECTION .text
GLOBAL _start
_start:
	print msg3, msg3len
	sgdt [GDTRl]    ;store GDTR (Global Descriptor Table Register)
	sidt [IDTRl]
	sldt [LDTR]
;..............................................................................
	print msg1, msg1len
	mov edi, digits		;initialize pointer to the start of string
	mov esi, GDTRb
	mov cl, 04		;GDTR base = 32 bits
	call CONVERT

	print digits, 8		; so string of 8 nibbles
	print colon, 1

	mov esi, GDTRl
	mov edi, digits
	mov cl, 02		;GDTR limit = 16 bits
	call CONVERT
	print digits, 4		; so string of 4 nibbles
	print newln, 1
;-------------------------------------------------------------------------------	
	print msg2, msg2len
	mov edi, digits		;initialize pointer to the start of string
	mov esi, IDTRb
	mov cl, 04		;IDTR base = 32 bits
	call CONVERT

	print digits, 8		; so string of 8 nibbles
	print colon, 1

	mov esi, IDTRl
	mov edi, digits
	mov cl, 02		;IDTR limit = 16 bits
	call CONVERT
	print digits, 4		; so string of 4 nibbles
	print newln, 1
;-------------------------------------------------------------------------------
    print msg4, msg4len
	mov edi, digits		;initialize pointer to the start of string
	mov esi, LDTR
	mov cl, 02		;LDTR = 16 bits
	call CONVERT
	print digits,4	

	mov eax, 01		;exit with return code 0
	mov ebx, 00
	int 80h
;.........................end of the main prog.................................

CONVERT:	
	mov edx, 0
	mov dl, cl		;cl = no of bytes to convert
	dec edx			;largest offset = no. of bytes - 1
	add esi, edx
	
	again:	
	mov al, byte[esi]	;get byte
	and al, 0F0h		; mask lower nibble to get upper nibble
	shr al, 04h
	cmp al, 0ah
	jb add_30h
	add al, 37h
	jmp store
	
	add_30h:
	add al, 30h

	store:
	mov [edi],al
	inc edi
	
	mov al, byte[esi]
	and al, 0Fh
	cmp al, 0ah
	jb add_30h1
	add al, 37h
	jmp store1
	
	add_30h1:
	add al, 30h

	store1:
	mov [edi], al
	inc edi
	dec esi
	dec cl
	jnz again

	ret
