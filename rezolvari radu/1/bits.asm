%include "utils/printf32.asm"

extern printf

section .data
    num dd 55555123

section .text
global main

main:
    push ebp
    mov ebp, esp

    ;TODO a: print least significant 2 bits of the second most significant byte of num
    ; num   33	B4	4F	03 (little endian)
    ; 4F = 1000 1111
    ; A = 1010 -> al 10 caracter hexa

    ; cum fac sa obtin al doilea cel mai semnificativ octet (si doar el)
    ; folosind shiftari;

    ; num >> 8 => raman cu cei mai semnifcativi 3 octeti
    ; num >> 16 => raman cu cei mai semnificativi 2 octeti

    ; num << 8 => raman cu cei mai putin semnificativ 3 octeti
    ; num << 16 => raman cu cei mai putin semnificativi 2 octeti

    ; (num << 8) >> 8 => raman cu cei mai putin semnificativ 3 octeti (pe pozitia lor initiala)
    ; (num << 16) >> 16 => raman cu cei mai putin semnificativi 2 octeti (pe pozitia lor initiala)

    ; num = (num << 8) (scap de primul cel mai semnificativ)
    ; num = (num >> 8) (revin in configuratia initiala, mai putin primul octet)
    ; num = (num >> 16) (scap de ultimii 2 octeti)

    ; num & 3 (num & 00000011)

    mov eax, dword[num]

    shl eax, 8
    shr eax, 8
    shr eax, 16
    and eax, 3; num = num & 3

    ; aici iau al doilea cel mai putin semnifcativ octet
    mov ebx, eax
    shr ebx, 1
    and ebx, 1

    ; aici iau cel mai putin semnificativ octet
    mov ecx, eax
    and ecx, 1

    PRINTF32 `%d%d\n\x0`, ebx, ecx

    ;TODO b: print number of bits set on odd positions
    ; un for de la 1 la 31 in care verific mereu ultimul bit

    mov ecx, 30

    xor eax, eax
for_loop:
    cmp ecx, 0
    jl finish
    mov ebx, dword[num];  numar initial
    shr ebx, cl; ebx >> 31, ebx >> 30, ... ebx >> 0
    and ebx, 1; iau ultimul bit, fix bit-ul de pe pozitia i (i incepe de la 31 si se termina la 0)
    add eax, ebx; (cand fac and ebx, 1 => pot obtine in ebx 1 sau 0; 1 - daca e setat, 0 daca nu e setat)
    sub ecx, 2
    jmp for_loop

finish:
    PRINTF32 `%d\n\x0`, eax

    ;TODO c: print number of groups of 3 consecutive bits set

    ; 111 -> cum verific, ca ultimii 3 biti sunt setati
    ; fac & 7 (7 = 4 + 2 + 1 = 00000111)
    ; fac & 3 => vad daca ultimii 2 biti sunt setati
    ; fac & 1 => vad daca ultimul bit e setat;

    ; V1
    ; fac tractoreala
    ; fac & 7, & (7 << 1)
    ; fac si cu 7 => numar & 00000111
    ; fac si cu (7 << 1) => numar & 00001110 
    ; ..

    ; V2
    ; netractoreala
    ; fac & 7 si ma shiftez mereu la dreapta
    ; cat timp fac asta? cat timp numarul meu e diferit
    ; in ecx voi tine minte contorul
    mov ecx, 0

    mov eax, dword[num]
check_for:
    cmp eax, 0
    je finish_task
    mov ebx, eax
    and ebx, 7; verific daca ultimii 3 biti sunt 111
    cmp ebx, 7; verific daca in ebx am 7
    jne skip
    inc ecx
skip:
    shr eax, 1
    jmp check_for

finish_task:
    PRINTF32 `%d\n\x0`, ecx

    xor eax, eax
    leave
    ret
