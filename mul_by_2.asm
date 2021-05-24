;24/05/21
;Introduction to Macro and Procedure

section .data
    msg1 db  "Enter a number: ", 0xa
    len1 equ $ - msg1
    msg2 db  "Multiplication by two is "
    len2 equ $ - msg2

section .bss
    num1 resb 1
    ans resb 1

%macro print 2
mov     eax, 4
mov     ebx, 1
mov     ecx, %1 ;msg
mov     edx, %2 ;len
int     80h
%endmacro

%macro input 2
mov     eax, 3
mov     ebx, 0
mov     ecx, %1
mov     edx, %2
int     80h
%endmacro

section .text
    global _start
_start:

    print msg1, len1
    
    input num1, 1
    mov ecx, [num1]
    sub ecx, '0'
    
    mov edx, '2'
    sub edx, '0'
    
    call multiply
    mov [ans], eax
    print msg2, len2
    print ans, 1

    mov     eax, 1
    int     80h
    
multiply:
    mov eax, ecx
    mul edx
    add eax, '0'
    ret


