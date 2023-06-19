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

section .text
global main
global get_last_digit

get_last_digit:
    push ebp
    mov ebp, esp

    ; Get argument from stack
    mov eax, [ebp+8]

    ; Divide eax by 10
    xor edx, edx ; Clear edx before division
    mov ecx, 10
    div ecx ; Divides the 64-bit quantity in EDX:EAX by ECX. Quotient in EAX, remainder in EDX

    ; Return the last digit (remainder) in eax
    mov eax, edx

    leave
    ret

compute_sum_digits:
    push ebp
    mov ebp, esp


    leave
    ret

main:
    push ebp
    mov ebp, esp

    ; Call `get_last_digit(N)`
    push dword [N]
    call get_last_digit
    add esp, 4 ; Clean the stack

    ; Print the result
    PRINTF32 `%d\n\x0`, eax

    ; Return 0.
    xor eax, eax
    leave
    ret

