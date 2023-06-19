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

compute_sum_digits:
    push ebp
    mov ebp, esp

    ; Get the argument from stack
    mov eax, [ebp+8]

    ; Initialize the sum to 0
    xor ecx, ecx

    ; Loop until the number becomes 0
    sum_loop:
        test eax, eax ; compare eax with 0
        jz end_sum_loop ; if eax is 0, exit the loop

        ; Compute the remainder (last digit)
        xor edx, edx ; clear edx before division
        mov ebx, 10
        div ebx ; divide eax by 10

        add ecx, edx ; add the remainder to the sum

        jmp sum_loop ; continue the loop

    end_sum_loop:

    ; Return the sum in eax
    mov eax, ecx

    leave
    ret

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

    ; Print `res` array
    mov ecx, len
    mov edi, res

    print_loop:
        mov eax, [edi]
        ;PRINTF32 `%d `, eax
        add edi, 4
        loop print_loop

    ;PRINTF32 `\n\x0`

    ; Compute the sum of digits of N
    push dword [N]
    call compute_sum_digits
    add esp, 4 ; Clean the stack

    ; Print the result
    PRINTF32 `%d\n\x0`, eax

    ; Return 0.
    xor eax, eax
    leave
    ret
