%include "utils/printf32.asm"

section .data
    num dd 55555123

section .text
global main

extern printf
main:
    push ebp
    mov ebp, esp

    ;TODO a: print least significant 2 bits of the second most significant byte of num
    mov eax, [num]
    shr eax, 16
    and eax, 3

    test eax, 2
    jz bit1_0
    PRINTF32 `a. %d\x0`, 1
    jmp skip_a
bit1_0:
    PRINTF32 `a. %d\x0`, 0
skip_a:
    test eax, 1
    jz bit2_0
    PRINTF32 `%d\n\x0`, 1
    jmp finish_a
bit2_0:
    PRINTF32 `%d\n\x0`, 0
finish_a:

    ;TODO b: print number of bits set on even positions
    mov eax, [num]
    xor ebx, ebx    ; aici retin numarul de biti setati pe pozitii pare
compute_bits:
    cmp eax, 0
    je finish_b
    test eax, 1
    jz not_set
    inc ebx
not_set:
    shr eax, 2
    jmp compute_bits

finish_b
    PRINTF32 `b. %d\n\x0`, ebx

    ;TODO c: print number of groups of 3 consecutive bits set
    xor ebx, ebx
    mov eax, [num]
compute_segments:
    cmp eax, 0
    je finish_c
    mov ecx, 7
    and ecx, eax
    cmp ecx, 7
    jne wrong
    inc ebx
wrong:
    shr eax, 1
    jmp compute_segments
finish_c:
    PRINTF32 `c. %d\n\x0`, ebx

    xor eax, eax
    leave
    ret
