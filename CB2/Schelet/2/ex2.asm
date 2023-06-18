%include "printf32.asm"

extern printf
extern calloc
extern scanf

section .data
    arr dd 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
    N dd 10
    P dd 400
    Q dd 850
    fmt_int db "%u ", 0
    fmt_newline db 10, 0
    a dd 1, 2

section .text
global main

;TODO a: Implementati functia `void print_array(unsigned int *a, int N)` pentru a afisa
;   elementele vectorului `a` de dimensiune `N` pe o singura linie separate de cate un spatiu.
;   
;   Afisarea se va face folosind functia `int printf(const char *format, ...);` din biblioteca standard C.

    


;   ATENTIE: Functia `printf` poate modifica registerele EAX, ECX si EDX. Pentru simplitate puteti folosi
;   instructiunile `pusha`, `popa` pentru a salva respectiv restaura toate registrele modificate de un apel de biblioteca.

print_array:
    push ebp
    mov ebp, esp

;   mov eax, 0
    mov ebx, 0
    mov ecx, 0
    mov esi, 0
    mov eax, [ebp+8]
    mov ebx, [ebp+12]
loop:
    mov eax, 0
    mov ebx, 0
    mov eax, [ebp+8]
    mov ebx, dword [eax+esi*4]
    push ebx
    push fmt_int
    call printf
    add esp, 8
    ;PRINTF32 `%d \n\x0`, ebx
    inc esi
    cmp esi, 10
    je end
    ;inc [arr]
    jmp loop
end:
    mov eax, [ebp+8]
    mov ebx, [ebp+12]
    leave
    ret

;TODO b: Implementati functia `int* alloc_array(int N)` care aloca memorie (dinamic) pentru `N` intregi. Memoria alocata va trebui zeroizata.
;   Pentru alocare de memorie puteti folosi functiile:
;   - `void *malloc(int size)`, care aloca `size` octeti. Memoria alocata nu este zeroizata.
;  SAU
;   - `void *calloc(size_t nmemb, size_t size)`, care aloca `nmemb` elemente fiecare de dimensiune `size`. Memoria alocata este zeroizata.
;
;   RECOMANDARE: folositi functia `calloc`
alloc_array:
    push ebp
    mov ebp, esp

    sub esp, 10
    lea esi, [ebp-10]
    mov ecx, 10
    mov byte [esi], 0
    sub esi, 10

    leave
    ret

;TODO c: Implementati functia `void read_array(unsigned int *a, int N)` care citeste de la intrarea standard
;   un vector `a` de `N` numere intregi fara semn.
;
;   Citirea de la intrarea standard se va face folosind functia `int scanf(const char *format, ...);` din biblioteca standard C.
;   e.g pentru citirea unui intreg
;       unsigned int elem;
;       scanf("%u", &elem);

read_array:
    push ebp
    mov ebp, esp
    mov ecx, 10
loop2:
    mov eax, 0
    mov ebx, 0
    mov eax, [ebp+8]
    lea ebx, [eax+esi*4]
    push ebx
    push fmt_int
    call scanf
    add esp, 8
    loop loop2

    ;push dword [N]
    ;push a
    ;call scanf
    ;add esp, 8
    

    ;push 

    leave
    ret

; TODO d: Implementati functia void update_interval(int *a, int N, int P, int Q)` care
;   va face urmatoarele operatii asupra sirului de elemente intregi fara semn `a` de dimensiune `N`"
;
;   a[i] = 2 * a[i], daca elementul a[i] se gaseste in intervalul [P, Q]
;   a[i] = a[i] / 2, daca elemente a[i] se gaseste in afara intervalului [P, Q]
;
; ATENTIE: este garantat ca P <= Q pentru toate apelurile functiei `update_interval`.

update_interval:
    push ebp
    mov ebp, esp

    leave
    ret

main:
    push ebp
    mov ebp, esp

    ; TODO a: Apelati functia `print_array(int *a, int N)` pentru a afisa vectorul `arr` de dimensiune `N` definit in sectiunea `.data`
    push dword [N]
    push arr
    call print_array
    add esp, 8

    ; TODO b: Alocati memorie pentru un vector de N intregi fara semn, apeland functia `alloc_array`
    ; si apoi afisati vectorul apeland functia `print_array`.
    push dword [N]
    push arr
    ;push alloc_array
    call alloc_array
    add esp, 4

    push dword [N]
    push arr
    call print_array
    add esp, 8

    ; TODO c: Cititi de la intrarea standard un vector de `N` intregi apeland functia `read_array`
    ; si apoi afisati vectorul folosind functia `print_array`.
    ;push arr
    ;push fmt_int
    ;call scanf
    ;add esp, 8


    ;push dword [N]
    push a
    call read_array
    add esp, 4

    push dword [N]
    push a
    call print_array
    add esp, 8


    ; TODO d: Transformati vectorul `a` de `N` elemente intregi fara semn citit la TODO c) apeland functia
    ; `update_array` si apoi afisati vectorul folosind functia `print_array`.
    ; Functia `update_array` va fi apelata astfel:
    ; `update_array(a, N, P, Q)` unde N, P si Q se gasesc in sectiunea `.data` iar vectorul `a` este cel citit la TODO c;



    ; Return 0.
    xor eax, eax
    leave
    ret
