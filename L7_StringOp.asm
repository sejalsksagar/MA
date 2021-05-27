;MA LAB #7 27/05/2021
;2372 SEJAL KSHIRSAGAR
;Write ALP using STRING instructions to accept a string
;from user and perform following operations:
;1. Convert a string to uppercase / lowercase
;2. Toggle the case of the string
;3. Concatenation of another string
;4. Find if it is palindrome

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
gmsg	db	"Given string is: "	
glen	equ	$ - gmsg	
menu	db	0xa,"Choose:",0xa,"1. Uppercase",0xa,"2. Lowercase",0xa,"3. Pallindrome",0xa,"4. Toggle",0xa	
mlen	equ	$ - menu
umsg	db	"The Uppercase string is: ",0xa	
ulen	equ	$ - umsg
lmsg	db	"The Lowercase string is: ",0xa	
llen	equ	$ - lmsg
pmsg	db	"The string is Pallindrome.",0xa	
plen	equ	$ - pmsg
nmsg	db	"The string is NOT Pallindrome.",0xa	
nlen	equ	$ - nmsg
tmsg	db	"The toggled string is : ",0xa	
tlen	equ	$ - tmsg
gstr    db  "SaaS"
gslen   equ $ - gstr

section .bss
nstr: resb 50
str3: resb 50
count: resb 50
choice: resb 10

section	.text
	global _start       ;must be declared for using gcc
_start:                     ;tell linker entry point
	
	print gmsg, glen
	print gstr, gslen
	
;	dec al
	mov byte[count], al ;length of given string
	
	print menu, mlen
	input choice, 10
	print choice, 10
	
	cmp byte[choice], 31h
	je CASE1
	cmp byte[choice], 32h
	je CASE2
	cmp byte[choice], 33h
	je CASE3
	cmp byte[choice], 34h
	je CASE4
	jmp EXIT
	
CASE1:
    mov esi, gstr ;start of the buffer
    mov edi, nstr ;start of the new string
    mov cl, [count]
UPPER:
    mov ch, [esi]
    cmp ch, 'a'
    jb COPYU ;char's ascii < 'a'
    cmp ch, 'z'
    ja COPYU ;char's ascii > 'z'
    sub ch, 20h ;else sub 20h to get uppercase char

COPYU:
    mov [edi], ch ;store to new string pointer location
    inc esi ;increment pointers
    inc edi
    dec cl ;decrement counter
    jnz UPPER
    
    print umsg, ulen
    print nstr, 50
    jmp EXIT
    
CASE2:
    mov esi, gstr ;start of the buffer
    mov edi, nstr ;start of the new string
    mov cl, [count]
LOWER:
    mov ch, [esi]
    cmp ch, 'A'
    jb COPYL ;char's ascii < 'A'
    cmp ch, 'Z'
    ja COPYL ;char's ascii > 'Z'
    add ch, 20h ;else add 20h to get lowercase char
COPYL:
    mov [edi], ch ;store to new string pointer location
    inc esi ;increment pointers
    inc edi
    dec cl ;decrement counter
    jnz LOWER
    
    print lmsg, llen
    print nstr, 50
    jmp EXIT
    
CASE3:
    mov esi, gstr
    mov ecx, 0
    mov cl, byte[count]
    mov esi, gstr
    mov edi, esi
    add edi, ecx
    dec edi
    shr cl, 1 ;no. of comparison divide by 2
PALLIN:
    mov al, [esi]
    mov bl, [edi]
    inc esi
    dec edi
    cmp al, bl
    jne NOTPALLIN
    dec cl
    jnz PALLIN
    print pmsg, plen
    jmp EXIT
NOTPALLIN:
    print nmsg, nlen
    jmp EXIT
    
CASE4:
    mov esi, gstr
    mov edi, nstr
    mov cl, [count]
TOGGLEU:
    mov al, [esi]
    cmp al, 'A'
    jb COPYT
    cmp al, 'Z'
    ja TOGGLEL
    add al, 20h ;if uppercase char add 20h to get lowercase
    jmp COPYT
TOGGLEL:
    cmp al, 'a'
    jb COPYT
    cmp al, 'z'
    ja COPYT
    sub al, 20h ;if lowercase char sub 20h to get uppercase
COPYT:
    mov [edi], al
    inc esi
    inc edi
    dec cl
    jnz TOGGLEU
    
    print tmsg, tlen
    print nstr, 50
    jmp EXIT
	
EXIT:
	mov	eax, 1	    ;system call number (sys_exit)
	int	0x80        ;call kernel

