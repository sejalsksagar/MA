SECTION .data

msg db "Hello "
msglen equ $-msg
err db "No command line arguments",0Ah
errlen equ $-err
err1 db "Too many command line arguments",0Ah
err1len equ $-err1


SECTION .bss
uname:resb 10
len:resq 01


SECTION .text


GLOBAL _start
_start:
pop ecx ;count of arguements
cmp ecx,1 ;arguement = 1, no name
je error1
cmp ecx,2 ;arguements > 2, more than one name
ja error2


pop edx ;arguement1 offset (not required)
pop edx ;arguement2 offset
mov esi,edx     ; file address pointed in rsi
mov edi,uname
mov ecx,0
copy:
mov al,[esi]
      cmp al,00
      je done
      mov byte [edi],al
      inc edi 
      inc esi
      inc ecx
      jmp copy
     
done:
mov eax,4
mov ebx,1
mov ecx,msg 
    mov edx,msglen
int 80h


  mov eax,4
mov ebx,1
mov ecx,uname
    mov edx,[len]
int 80h
    jmp end


error1:
mov eax,4
mov ebx,1
mov ecx,err 
    mov edx,errlen
int 80h
       
    jmp end


error2:
mov eax,4
mov ebx,1
mov ecx,err1 
    mov edx,err1len
int 80h


end:
mov eax,1
    mov ebx,0
int 80h




; OUTPUT


;[ccoew@localhost ~]$ nasm -f elf64 command_line.asm
;[ccoew@localhost ~]$ ld -o command_line command_line.o


;[ccoew@localhost ~]$ ./command_line
;No command line arguments


;[coew@localhost ~]$ ./command_line friends.
;Hello friends.


;coew@localhost ~]$ ./command_line friends all
;Too many command line arguments
