;MA LAB #5 25/05/2021
;2372 SEJAL KSHIRSAGAR
;Write ALP to perform basic arithmetic operations
;and check the output in the debugger.

%macro print 2
mov eax, 4
mov ebx, 1
mov ecx, %1
mov edx,%2
int 80h
%endmacro

%macro input 2
mov     eax, 3
mov     ebx, 0
mov     ecx, %1
mov     edx, %2
int     80h
%endmacro

%macro initialize 2
mov al, byte[%1]
sub al, '0'     ;convert ascii to binary
mov bl, byte[%2]
sub bl, '0'
%endmacro

section	.data
askMsg db  "Enter a number: ",0ah
asklen equ $ - askMsg
msg db "ARITHMETIC OPERATIONS: ",0ah
len equ $-msg
n1Msg db "Entered number (num1) is: ",
n1len equ $-n1Msg
n2Msg db "Other number (num2) is: ",
n2len equ $-n2Msg
addMsg db "Addition is: "
addlen equ $-addMsg
subMsg db "Subtraction is: "
sublen equ $-subMsg
mulMsg db "Multiplication is: "
mullen equ $-mulMsg
divMsg db "Division - Quotient is: "
divlen equ $-divMsg
remMsg db "Remainder is: "
remlen equ $-remMsg

newline db " ",0ah
nwlen equ $-newline

num2 db '2'

section .bss
num1 resb 1
ans resb 1
rem resb 1

section	.text
	global _start       ;must be declared for using gcc
_start:                     ;tell linker entry point
    print askMsg, asklen
    input num1, 1
    
    print n1Msg, n1len
    print num1, 1
    print newline, nwlen
    print n2Msg, n2len
    print num2, 1
    print newline, nwlen
    
    print newline, nwlen
    print msg, len
    
    initialize num1, num2
    add al, bl
    add al, '0'     ;convert binary to ascii to display
    mov byte[ans], al
    
    print addMsg, addlen
    print ans, 1
    print newline, nwlen
    
    initialize num1, num2
    sub al, bl
    add al, '0'
    mov byte[ans], al
    
	print subMsg, sublen
    print ans, 1
    print newline, nwlen
    
    initialize num1, num2
    mul bl      ;al = al*bl
    add al, '0'
    mov byte[ans], al
    
	print mulMsg, mullen
    print ans, 1
    print newline, nwlen
    
    initialize num1, num2
    mov ah, 0
    div bl      ;al = ax/bl, ah = remainder
    add al, '0'
    add ah, '0'
    mov byte[ans], al
    mov byte[rem], ah
    
	print divMsg, divlen
    print ans, 1
    print newline, nwlen
	print remMsg, remlen
    print rem, 1
	
	mov	eax, 1	    ;system call number (sys_exit)
	int	0x80        ;call kernel
