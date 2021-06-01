%macro print 2
mov eax, 4
mov ebx, 1
mov ecx, %1
mov edx, %2
int 80h
%endmacro

%macro print_array 2
    mov     esi, %1 ;array                        ; get pointer to array
    mov     edi, %2-1 ;arraylen - 1               ; edi = number of array elements
    call    PRINT
%endmacro

%macro even_index 2
    mov     esi, %1 ;array                         
    mov     edi, %2-1  ;arraylen - 1             
    call    EVEN_INDEX
%endmacro

%macro odd_index 2
    mov     esi, %1 ;array                     
    mov     edi, %2-2 ;arraylen - 2              
    call    ODD_INDEX
%endmacro

%macro decrementby1 2
    mov esi, %1 ;array                      
    mov edi, %2-1 ;arraylen - 1              
    call DECR
%endmacro

%macro incrementby1 2
    mov esi, %1 ;array                        ; get pointer to array
    mov edi, %2-1 ;arraylen - 1               ; edi = number of array elements
    call INCR
%endmacro

%macro minimum 2
    mov esi, %1 ;array                     
    mov edi, %2-2 ;arraylen - 2              
    mov ecx,[esi]
    add esi,4
    call MIN
%endmacro

%macro maximum 2
    mov esi, %1 ;array                     
    mov edi, %2-2 ;arraylen - 2             
    mov ecx,[esi]
    add esi,4
    call MAX
%endmacro

%macro sum_array 2
    mov     esi, %1 ;array                     
    mov     edi, %2-1 ;arraylen - 1               
    mov     ax, 0
    call    SUM
%endmacro


section .bss
temp:       resd	10
min         resd     2 
max         resd     2


section .data

    msg db "************* ARRAY **************", 0xa, 0xa
    len equ $-msg
    gmsg db "Given array: "
    glen equ $-gmsg
    o1msg db "Elements at even index: "
    o1len equ $-o1msg
    o2msg db "Elements at odd index: "
    o2len equ $-o2msg
    o3msg db "Array incremented by 1: "
    o3len equ $-o3msg
    o4msg db "Array decremented by 1: "
    o4len equ $-o4msg
    o5msg db "Minimum element in given array: "
    o5len equ $-o5msg
    o6msg db "Maximum element in given array: "
    o6len equ $-o6msg
    omsg db "Array sum: "
    olen equ $-omsg

    array dd     8, 7, 6, 5, 4, 3, 2, 1
    arraylen equ ($ - array) / 4            ; array length * 4 = number of elements
    
    space db "  "
    splen equ $-space
    
    nwl db " ",0xa, 0xa
    nwlen equ $-nwl
    
    sum db '0'
    sum1 db '0'
    sum2 db '0'
    

section .text

    global _start:

_start:
    ;Given array
    print       msg, len
    print       gmsg, glen
    print_array array, arraylen
    print       nwl, nwlen

    ;Elements at even/odd index
    print       o1msg, o1len
    even_index array, arraylen
    print       nwl, nwlen
    
    print       o2msg, o2len
    odd_index array, arraylen
    print       nwl, nwlen
    
    ;Increment/Decrement by 1
    call RESET_ARRAY
    print       o3msg, o3len
    incrementby1 temp, arraylen
    print_array temp, arraylen
    print       nwl, nwlen
    
    call RESET_ARRAY
    print       o4msg, o4len
    decrementby1 temp, arraylen
    print_array temp, arraylen
    print       nwl, nwlen
    
    ;Minimum/Maximum element
    print       o5msg, o5len
    minimum array, arraylen
    print       nwl, nwlen
    
    print       o6msg, o6len
    maximum array, arraylen
    print       nwl, nwlen
    
    ;Array sum
    print       omsg, olen
    sum_array array, arraylen
    


EXIT: 
    mov     ebx, 0
    mov     eax, 1
    int 80h
    
PRINT:
    mov     eax, 4          ; sys_write
    mov     ebx, 1
    mov     ecx, [esi]      ; get current array element
    add     ecx, '0'        ; add '0' to convert to ASCII
    push    ecx             ; push to stack since we need an address of item to print
    mov     ecx, esp        ; esp is the stack pointer ; mov address of char to ecx 
    mov     edx, 1          ; print 1 byte 
    int     80h             ; now print it
    print   space, splen
    pop     ecx             ; balance stack
    add     esi, 4          ; get next element, 4 because it's an array of dwords
    dec     edi             ; decrease loop counter
    jns     PRINT           ; if edi != -1 continue loop (SF=0)
    ret
    
EVEN_INDEX:
    mov     eax, 4
    mov     ebx, 1
    mov     ecx, [esi]                     
    add     ecx, '0'        ; add '0' to convert to ASCII
    push    ecx             ; push to stack since we need an address of item to print
    mov     ecx, esp        ; mov address of char to ecx
    mov     edx, 1          ; print 1 byte 
    int     80h             ; now print it
    print   space, splen
    pop     ecx             ; balance stack
    add     esi, 8          ; get next to next element
    sub     edi, 2          ; decrease loop counter twice
    jns     EVEN_INDEX      ; if edi != -1 continue loop (SF=0)
    ret
    
ODD_INDEX:
    mov     eax, 4
    mov     ebx, 1
    mov     ecx, [esi+4]                     
    add     ecx, '0'        ; add '0' to convert to ASCII
    push    ecx             ; push to stack since we need an address of item to print
    mov     ecx, esp        ; mov address of char to ecx
    mov     edx, 1          ; print 1 byte 
    int     80h             ; now print it
    print   space, splen
    pop     ecx             ; balance stack
    add     esi, 8          ; get next to next element
    sub     edi, 2          ; decrease loop counter twice
    jns     ODD_INDEX       ; if edi != -1 continue loop (SF=0)
    ret
    
RESET_ARRAY:
    mov edi, temp
	mov esi, array
	mov ecx, 8
	rep movsd
	ret
    
DECR:
    mov ecx, [esi]      ; get current array element
    dec ecx             ; decrement current array element
    mov [esi], ecx      ; update current array element             
    add esi, 4          ; get next element
    dec edi             ; decrease loop counter
    jns DECR            ; if edi != -1 continue loop (SF=0)
    ret
    
INCR:
    mov ecx, [esi]      ; get current array element
    inc ecx             ; increment current array element
    mov [esi],ecx       ; update current array element 
    add esi, 4          ; get next element
    dec edi             ; decrease loop counter
    jns INCR            ; if edi != -1 continue loop (SF=0)
    ret    
	
MIN:
        cmp [esi], ecx  ; compare current array element with current minimum
        jl UPDATEMIN    ; if current element is less than current mimimum
        add esi,4       ; get next element
        dec edi         ; decrease loop counter
        jns MIN         ; if edi != -1 continue loop (SF=0)
        jmp DONEMIN     ; if entire array is traversed
    
    UPDATEMIN:
        mov ecx,[esi]   ; update value of minimum
        add esi,4       ; get next element
        dec edi         ; decrease loop counter
        jns MIN         ; if edi != -1 continue loop (SF=0)
    
    DONEMIN:
        add ecx,'0'     ; add 48 to convet to ASCII
        mov [min],ecx   ; store value of minimum 
        print min,2     ; print minimum
        ret
        
MAX:
        cmp [esi], ecx  ; compare current array element with current maximum
        jg UPDATEMAX    ; if current element is greater than current maximum
        add esi,4       ; get next element
        dec edi         ; decrease loop counter
        jns MAX         ; if edi != -1 continue loop (SF=0)
        jmp DONEMAX     ; if entire array is traversed
    
    UPDATEMAX:
        mov ecx,[esi]   ; update value of maximum
        add esi,4       ; get next element
        dec edi         ; decrease loop counter
        jns MAX         ; if edi != -1 continue loop (SF=0)
    
    DONEMAX:
        add ecx,'0'     ; add '0' to convert to ASCII
        mov [max],ecx   ; store value of maximum 
        print max,2     ; print maximum
        ret
        
        
SUM:
    mov     cx, [esi]      ; get current array element
    add     ax, cx         ; add current element
    add     esi, 4         ; get next element 
    dec     edi            ; decrement count
    jns     SUM
    
    mov     [sum], ax
    mov     al, [sum]
    mov     ah, 0
    mov     dl, 10
    div     dl          ;al = ax/dl, ah = remainder ;---> AL=3   AH=6
    add     ax, 3030h    ;---> AL="3" AH="6"
    mov     [sum1], al 
    mov     [sum2], ah 
    print   sum1, 1
    print   sum2, 1
    print   nwl, nwlen
    ret
