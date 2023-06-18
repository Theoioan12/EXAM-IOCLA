%include "utils/printf32.asm"

extern puts
extern printf

section .data
    num dd 55555123
    arr db 0
    array db "abcde", 0
;;  TODO d: declare byte_array so that PRINT_HEX shows babadac 
    byte_array db 0
	
section .text
global main

; TODO b: implement array_reverse
array_reverse:
    push ebp
    mov ebp, esp

    mov eax, [ebp + 8]  ; arr
    mov ecx, [ebp + 12] ; len

    xor esi, esi

reverse_process:
    xor edx, edx
    xor ebx, ebx
    mov dl, byte [eax + esi]
    mov bl, byte [eax + ecx - 1]

    mov [eax + esi], bl
    mov [eax + ecx - 1], dl
    
    inc esi
    dec ecx
    cmp ecx, esi
    jge reverse_process
    
    
    leave
    ret

; TODO c: implement pow_arraypowArray
pow_array:

main:
    push ebp
    mov ebp, esp

    ; TODO a: allocate on array of 20 byte elements and initializate it incrementally starting from 'A'
    sub esp, 20
    mov ecx, 20
    mov al, 'A'

create_arr:
    mov byte [esp], al
    inc eax
    inc esp
    loop create_arr

print:
    lea esi, [esp]
    PRINTF32 `%s\n\x0`, esi
    ; TODO b: call array_reverse and print reversed array
    ; xor eax, eax

    ; push dword 5
    ; push edx
    ; call array_reverse
    ; add esp, 8

    ; PRINTF32 `%s\n\x0`, eax
    
    ;TODO c: call pow_array and print the result array

	;;  TODO d: this print of an uint32_t should print babadac 
	; PRINTF32 `%x\n\x0`, byte_array

    xor eax, eax
    leave
    ret
