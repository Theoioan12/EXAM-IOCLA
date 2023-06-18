extern strlen
extern printf


section .rodata
    test_str db "hell, it's about time", 0
    format db "length = %d", 10, 0
    format_ch db "c = %s", 10, 0

section .text
global main


my_strlen:
    enter 0,0
    
    mov eax, dword[ebp + 8]
    
    cmp byte[eax], 0
    jz finish

    add eax, 1
    push eax
    call my_strlen
    add esp, 4  
    add eax, 1

    
    jmp exit

finish:
	  mov eax, 0

exit:
		leave
		ret

main:
    push ebp
    mov ebp, esp
    push test_str
    call strlen
    add esp, 4


    push eax
    push format
    call printf
    add esp, 8


    ; TODO a: Implement strlen-like functionality using a RECURSIVE implementation.
    push test_str
    call my_strlen
    add esp, 4

    push eax
    push format
    call printf
    add esp, 8

    ; Return 0.
    xor eax, eax
    leave
    ret
