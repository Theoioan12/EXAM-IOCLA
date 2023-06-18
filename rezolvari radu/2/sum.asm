extern scanf
extern printf
extern malloc
extern free

section .data
    int_format db "%d", 0
    int_format_print db "%d", 10, 0
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


alloc_array:
    push ebp
    mov ebp, esp;

    ; n * 4, daca nu vreau sa fac inmultire (n << 2)

    mov ecx, [ebp + 8]; n 
    shl ecx, 2

    push ecx
    call malloc
    add esp, 4

    ; pentru o functie, valoarea de retur se afla in eax
    ; eax = 0x0804aabb

    leave
    ret

read_array:
    ; enter 0, 0
    push ebp
    mov ebp, esp

    mov ecx, dword[ebp + 8]; n
    mov edx, dword[ebp + 12]; v

    mov ebx, 0

cmp_for:
    cmp ebx, ecx
    jge finish

    ; Trebuie sa facem logica noastra
    
    push ebx
    push ecx
    push edx

    lea esi, [edx + 4 * ebx]
    push esi
    push int_format
    call scanf
    add esp, 8
    
    pop edx
    pop ecx
    pop ebx

    inc ebx
    jmp cmp_for 

finish:
    leave
    ret

sum:
    push ebp
    mov ebp, esp;

    mov edx, dword[ebp + 8]; edx retine vectorul
    mov ecx, dword[ebp + 12]; ecx retine numarul de numere din vector;

    xor eax, eax; 

compute_sum:
    add eax, dword[edx + 4 * ecx - 4]
    loop compute_sum

    leave
    ret



main:
    push ebp
    mov ebp, esp

    push dword 5 ; -> pun valoarea 5 pe stiva (ca int); [ebp - 4] sau [esp]

    push dword[ebp - 4]
    call alloc_array
    add esp, 4

    ; in eax am o adresa care tine minte o zona de n int-uri
    push eax; vreau sa salvez pe eax, ca sa il nu il pierd

    push eax; il dau pe eax parametru la functie
    push dword[ebp - 4]
    call read_array
    add esp, 8

    pop eax; si in acest moment, eax tine minte o zona de n int-uri tocmai citite

    push eax; vreau sa salvez pe eax, ca sa il nu il pierd

    push dword[ebp - 4]; numar elemente
    push eax; vector
    call sum
    add esp, 8

    ; acum in eax am suma numerelor. daca dau pop eax pierd suma numerelor si voi avea 
    ; adresa catre zona de n int-uri tocmai citite;

    mov ebx, eax; ebx va tine minte suma
    pop eax; acum eax va tine minte adresa
    
    push eax; salvez eax, imi trebuie pentru free

    push ebx; parametru pentru printf
    push int_format_print
    call printf
    add esp, 8

    pop eax; restaurez eax

    push eax
    call free
    add esp, 4

    xor eax, eax
    leave
    ret
