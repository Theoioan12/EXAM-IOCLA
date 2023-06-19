%include "./utils/printf32.asm"
extern printf

section .data

int_fmt_newline db "%d ", 10, 0
int_fmt db "%d ", 0
newline_fmt db 10, 0

N dd 12349
arr dd 12341, 2, 3123, 1914, 99995, 6666, 7, 88, 129, 10000
len equ 10

section .bss
; Reserve memory for an array named `res` storing `len` integers
res resd len

section .text
global main

main:
    push ebp
    mov ebp, esp

    ; Compute the last digit for all `len` elements of `arr` array and store the results in `res` array
    mov ecx, len ; loop counter
    mov edi, arr ; source array
    mov esi, res ; destination array

calc_loop:
    mov eax, [edi] ; load an element from source array

    ; Compute the last digit
    xor edx, edx ; clear edx before division
    mov ebx, 10
    div ebx ; divide eax by 10

    mov [esi], edx ; store the result (remainder)

    add edi, 4 ; next source element
    add esi, 4 ; next destination element
    loop calc_loop

    ; Compute the last digit of N
    mov eax, [N]
    xor edx, edx
    div ebx

    ; Print the result
    PRINTF32 `%d\n\x0`, edx

    ; Print `res` array
    mov ecx, len
    mov edi, res

print_loop:
    mov eax, [edi]
    PRINTF32 `%d\n\x0`, eax
    add edi, 4
    loop print_loop

    ;PRINTF32 `\n\x0`

    ; Return 0.
    xor eax, eax
    leave
    ret
