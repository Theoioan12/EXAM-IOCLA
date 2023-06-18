%include "printf32.asm"

extern printf

section .bss
    results resw 9

section .data
    lap_times dw 0x37E, 0x321, 0x3FD, 0x3A5, 0x357, 0x385, 0x39B, 0x36F, 0x3E5, 0x31A
    lap_times_len equ $ - lap_times
    c_results_len equ 9
    d_results_len equ 8

section .text
global main

main:
    push ebp
    mov ebp, esp

    ; TODO a: Aflați timpul minim și timpul maxim din vectorul lap_times.
    ; Salvați timpul minim pe prima poziție din vectorul results, iar timpul
    ; maxim pe cea de-a doua poziție.


    ; Afișare rezultat pentru subpunctul a). Nu modificați!
    PRINTF32 `%hd %hd\n\x0`, word [results], word [results + 2]


    ; TODO b: Aflați câtul și restul împărțirii sumei timpilor din prima
    ; jumătate de antrenament la suma timpilor din cea de-a doua jumătate de
    ; antrenament.
    ; Salvați câtul împărțirii pe prima poziție din vectorul results, iar restul
    ; împărțirii pe cea de-a doua poziție.


    ; Afișare rezultat pentru subpunctul b). Nu modificați!
    PRINTF32 `%hd %hd\n\x0`, word [results], word [results + 2]


    ; TODO c: Aflați diferențele dintre timpi, doi câte doi.
    ; Plasați rezultatele în vectorul results.


    ; Afișare rezultat pentru subpunctul c). Nu modificați!
    mov edx, results
    mov ecx, c_results_len

print_c_loop:
    PRINTF32 `%hd \x0`, word [edx]
    add edx, 2
    loop print_c_loop

    PRINTF32 `\n\x0`


    ; TODO d: Aflați în binar numărul de timpi de antrenament care au al treilea
    ; cel mai puțin semnificativ bit setat.
    ; Numărul de timpi de antrenament care au al treilea cel mai puțin
    ; semnificativ bit setat încape garantat într-un octet.
    ; Testați fiecare bit din acest număr și salvați pe poziții succesive în
    ; vectorul "results" valoarea 0 dacă bitul testat este 0, sau valoarea 1
    ; dacă bitul testat este 1.
    ; Cel mai semnificativ bit se va afla pe prima poziție din vectorul results,
    ; iar ce cel mai puțin semnificativ bit se va afla pe cea de-a opta poziție
    ; din vector.


    ; Afișare rezultat pentru subpunctul d). Nu modificați!
    mov edx, results
    mov ecx, d_results_len

print_d_loop:
    PRINTF32 `%hd\x0`, word [edx]
    add edx, 2
    loop print_d_loop

    PRINTF32 `\n\x0`

    ; Return 0.
    xor eax, eax
    leave
    ret
