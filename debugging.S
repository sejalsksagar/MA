# https://www.onlinegdb.com/
# using online GCC Assembler for debugging


sys_read      =       0
sys_write     =       1
sys_exit      =       60

.global main

.data
msg:
        .ascii  "Result of Addition = "
        
num1:   .long 255
num2:   .long 23

.bss
ans:

.text

main:
	mov $1, %al 
	mov $0, %ah
	mov $2, %bl 
	
	add %al, %bl 
	mov %bl, %cl
	
	mov $ans, %rsi
	mov %bl, (%rsi) 
	add $0x30, (%rsi)
	
# write(1, msg, 13)
    mov $1, %rax
    mov $1, %rdi
    mov $msg, %rsi
    mov $21, %rdx
    syscall
    
    mov $1, %rax
    mov $1, %rdi
    mov $ans, %rsi
    mov $2, %rdx
    syscall
    
    mov $60, %rax
    xor %rdi, %rdi
    syscall
    
	ret
	
