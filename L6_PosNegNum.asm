;MA LAB #6 26/05/2021
;2372 SEJAL KSHIRSAGAR
;Write ALP to accept a signed number and check if it is
;positive or negative. Display appropriate message.

%macro print 2
mov eax, 4
mov ebx, 1
mov ecx, %1
mov edx, %2
int 80h
%endmacro

%macro input 2
mov     eax, 3
mov     ebx, 0
mov     ecx, %1
mov     edx, %2
int     80h
%endmacro

section	.data
inMsg db "Enter a number: ", 0xa
inlen equ $-inMsg
oMsg db "Entered number is: "
olen equ $-oMsg
pMsg db "Input is positive! "
plen equ $-pMsg
nMsg db "Input is negative! "
nlen equ $-nMsg
vMsg db "Input is not a number! "
vlen equ $-vMsg

nwl db " ",0xa
nwlen equ $-nwl

section .bss
num resb 5

section	.text
	global _start       ;must be declared for using gcc
_start:                     ;tell linker entry point
	
	print inMsg, inlen
    input num, 5
    
    print oMsg, olen
    print num, 5
    print nwl, nwlen
    
    mov esi, num
    mov al, byte[esi]
    
    cmp al, '+'
    je POSITIVE
    
    cmp al, '-'
    je NEGATIVE
    
    cmp al, 30h
    jl INVALID
    jg POSITIVE
    
    
POSITIVE:
    cmp al, 39h
    jg INVALID
    print pMsg, plen
    jmp EXIT
    
NEGATIVE:
	print nMsg, nlen
	jmp EXIT
    
INVALID:
    print vMsg, vlen
    jmp EXIT
	
EXIT:
	mov	eax, 1	    ;system call number (sys_exit)
	int	0x80        ;call kernel

