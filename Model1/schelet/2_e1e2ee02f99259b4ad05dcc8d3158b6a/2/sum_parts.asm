extern scanf
extern printf


section .data
    uint_format    db "%zu", 0
    uint_format_newline    db "%zu", 10, 0
    pos1_str    db "Introduceti prima pozitie: ", 0
    pos2_str   db "Introduceti a doua pozitie: ", 0
    sum_str db "Suma este: %zu", 10, 0
    sum_interval_str db "Suma de la pozitia %zu la pozitia %zu este %zu", 10, 0
    arr     dd 100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400
    len equ $-arr

section .bss
    pos1 resd 1         ; declar 2 intregi
    pos2 resd 1

section .text
global main


sum:
    push ebp
    mov ebp, esp

    ; TODO a: Implement sum() to compute sum for array.
    mov esi, arr
    mov ecx, len
    shr ecx, 2      ; am retinut aici numarul de elemente din arr

    xor eax, eax    ; aici pun suma
compute_sum:
    add eax, [esi]
    add esi, 4
    loop compute_sum

    leave
    ret


sum_interval:
    push ebp
    mov ebp, esp

    ; TODO b: Implement sum_interval() to compute sum for array between two positions.
    mov esi, [ebp + 8]      ; pun vectorul in esi
    mov ebx, [ebp + 12]     ; capatul stang
    mov ecx, [ebp + 16]     ; capatul drept
    xor eax, eax            ; aici pun suma

compute_sum_intervals
    cmp ebx, ecx
    jge finish_task_b
    add eax, [esi + 4*ebx]
    inc ebx
    jmp compute_sum_intervals

finish_task_b:
    mov ebx, [ebp + 8]
    mov ecx, [ebp + 12]
    leave
    ret


main:
    push ebp
    mov ebp, esp


    push dword 14
    push arr
    call sum
    add esp, 8

    push eax
    push sum_str
    call printf
    add esp, 8


    ; TODO b: Call sum_interval() and print result.
    push dword 9
    push dword 5
    push arr
    call sum_interval
    add esp, 12

    push eax
    push dword 9
    push dword 5
    push sum_interval_str
    call printf
    add esp, 16
    ; TODO c: Use scanf() to read positions from standard input.

    push pos1_str
    call printf
    add esp, 4

    push pos1
    push uint_format
    call scanf
    add esp, 8

    push pos2_str
    call printf
    add esp, 4

    push pos2
    push uint_format
    call scanf
    add esp, 8

    push dword [pos2]
    push dword [pos1]
    push arr
    call sum_interval
    add esp, 12

    push eax
    push dword [pos2]
    push dword [pos1]
    push sum_interval_str
    call printf
    add esp, 16

    ; Return 0.
    xor eax, eax
    leave
    ret
