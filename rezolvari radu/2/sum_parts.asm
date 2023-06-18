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

section .bss
    pos1 resd 1; declar un int[1]
    pos2 resd 1; declar un int[1]


section .text
global main


sum:
    push ebp
    mov ebp, esp

    ; TODO b: Implement sum() to compute sum for array.
    ; la o functie e important sa retinem:
    ; primul parametru se afla la ebp + 8
    ; al doilea parametru se afla la ebp + 12
    ; al N-lea parametru se afla la ebp + (N + 1) * 4
    ; rezultatul functiei e mereu stocat in eax 

    ; la inceput de functie am mereu
    ; push ebp
    ; mov ebp, esp

    ; la final de functie am mereu
    ; leave
    ; ret

    mov edx, dword[ebp + 8]; edx retine vectorul
    mov ecx, dword[ebp + 12]; ecx retine numarul de numere din vector;

    xor eax, eax; eax retine suma; xor ceva, ceva <=> ceva = 0 (se poate si mov ceva, 0)

    ; asocierea: int = dword = dd = resd
    ; asocierea: short = word = dw = resw
    ; asocierea: char = byte = db = resb 

compute_sum:
    ; ecx = primeste numarul de elemente => v = {1, 2, 3, 4, 5}, n = 5, ecx = 5
    ; v[1] = incepe la v + 4
    ; v[2] = incepe la v + 8
    ; v[4] = incepe la v + 16

    ; ecx - 1, 2 * ecx - 2, 4 * ecx - 4

    add eax, dword[edx + 4 * ecx - 4]
    loop compute_sum

    leave
    ret


sum_interval:
    push ebp
    mov ebp, esp

    mov edx, [ebp + 8]; edx retine vectorul
    mov ecx, [ebp + 12]; ecx retine marginea din stanga
    mov ebx, [ebp + 16]; ebx retine marginea din dreapta

    xor eax, eax; eax = 0
    
    ; [left, right)
test_compare:
    cmp ecx, ebx
    jge finish
    add eax, [edx + 4 * ecx]
    inc ecx
    jmp test_compare


    ; TODO b: Implement sum_interval() to compute sum for array between two positions.
finish:
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
    ; daca am f(e1, e2, ..., en)
    ; push en
    ; push e_(n - 1)
    ;...
    ; push e2
    ; push e1
    ; call f
    ; add esp, n * 4, 

    ; sum_interval(1, 4)

    push  pos1_str
    call printf
    add esp, 4

    push pos1
    push uint_format
    call scanf
    add esp, 8 

    push  pos2_str
    call printf
    add esp, 4

    push pos2
    push uint_format
    call scanf
    add esp, 8   

    ; pe stiva pot adauga cu push doar word si dword!! Nu pot da push cu ceva byte.
    push word[pos2]
    push word[pos1]
    push arr
    call sum_interval
    add esp, 4

    ;  sum_interval_str db "Suma de la pozitia %zu la pozitia %zu este %zu", 10, 0
    ; printf("Suma de la pozitia %zu la pozitia %zu este %zu\n", left, right, eax)
    push eax
    push dword[pos2]
    push dword[pos1]
    push sum_interval_str
    call printf
    add esp, 16



    ; TODO c: Use scanf() to read positions from standard input.
    ; scanf("%d", &x); citeste un int si il stocheaza la adresa lui x
    ; ASM, am spus ca fiecare label este o adresa. deci pos1 si pos2 sunt adrese;

    ; Return 0.
    xor eax, eax
    leave
    ret
