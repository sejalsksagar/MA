;MA Lab #1 20/05/21
;2372 Sejal Kshirsagar
;Write ALP to accept a string and display it on the screen.

section	.data
inMsg1	db	'Enter a string: ',0xa	
inMsg1len	equ	$ - inMsg1	
outMsg1	db	'Entered string is: '	
outMsg1len	equ	$ - outMsg1	

section 	.bss
str: resw 30
num resb 4

section	.text
	global _start       ;must be declared for using gcc
_start:                     ;tell linker entry point
    ;display inMsg1
	mov eax, 4              
	mov ebx, 1
	mov ecx, inMsg1
	mov edx, inMsg1len
	int 80h
	
	;read str
	mov eax, 3
	mov ebx, 0
	mov ecx, str
	mov edx, 30
	int 80h
	
	;display outMsg1
	mov eax, 4
	mov ebx, 1
	mov ecx, outMsg1
	mov edx, outMsg1len
	int 80h
	
	;display str
	mov eax, 4
	mov ebx, 1
	mov ecx, str
	mov edx, 30
	int 80h
	
	mov	eax, 1	    ;system call number (sys_exit)
	int	0x80        ;call kernel
