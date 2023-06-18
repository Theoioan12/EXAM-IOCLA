%include "printf32.asm"
extern printf

section .bss
	answer resw 20

section .data
    products dw 0x10AD, 0x234D, 0x03AD, 0x7E00, 0x0AFE, 0x00A1, 0x1B32, 0x0, 0x1, 0xA, 0x00CB, 0xFF, 0x1123, 0xFFFF, 0x64, 0x3FBC, 0x128, 0x341, 0x2345, 0x1AFE
    products_len equ 20
    c_answer_len equ 5

section .text
global main

main:
    push ebp
    mov ebp, esp

    ; TODO a: Afisati restul impartirii la 23, pentru fiecare element.
	; Fiecare rest se va salva in vectorul answer (acesta este tot un vector de
	; words).
    ; ATENTIE la registrele folosite. Un singur octet poate NU fi de ajuns
    ; pentru catul impartirii.
    mov ecx,products_len
    mov eax,[products]
    mov ebx,[answer]

    xor esi, esi
    mov esi, 23

    while1:
        xor edx, edx
        xor eax, eax
        mov ax, word [products + 2 * ecx - 2]
        div esi
        mov word [answer + 2 * ecx - 2], dx
    loop while1


    ;; INSTRUCTIUNI AFISARE subpunct a). NU MODIFICATI!
a_print:
    xor ecx, ecx
a_print_loop:
	PRINTF32 `%hd \x0`, [answer + 2 * ecx]
	mov word [answer + 2 * ecx], 0
	inc ecx
	cmp ecx, products_len
	jb a_print_loop
	PRINTF32 `\n\x0`


    ; TODO b: Afisati produsul dintre numarul de elemente pare si cel al
    ;  elementelor impare. Rezultatul se va pune pe prima pozitie din vectorul
	; answer.

    mov ecx, products_len
    xor eax, eax
    xor ebx, ebx    ; nr pare
    xor edx, edx    ; nr impare

while2:
    mov ax, word [products + 2*ecx - 2]
    test eax, 1         ; daca are ultimul bit 1, e nr impar
    jnz odd
    inc ebx
    jmp skip
odd:
    inc edx
skip:
    loop while2
    
    mov ax, bx          ; fac inmultirea
    mul dx
    mov [answer], ax

    ;; INSTRUCTIUNI AFISARE subpunct b). NU MODIFICATI!
b_print:
	PRINTF32 `%hd\n\x0`, [answer]
	mov word [answer], 0


    ; TODO c: Daca elementul se afla pe o pozitie multiplu de 3 sau de 5,
    ; verificati daca cel mai semnificativ octet este par. Daca este par
    ; faceti-i flip (ii inversati toti bitii). Puneti rezultatul fiecarui flip
	; in vectorul answer.

    xor eax, eax    ; aici retin pozitia
    mov ecx, products_len
    mov edi, c_answer_len

iterate:
    xor esi, esi
    mov eax, ecx    ; pun pozitia in eax
    sub eax, 1

    xor edx, edx
    mov esi, 3
    div esi
    cmp edx, 0
    jne check_5     ; daca nu e multiplu de 3, verific daca e multiplu de 5
    jmp compute
check_5:
    xor esi, esi
    mov eax, ecx
    sub eax, 1

    xor edx, edx
    mov esi, 5
    div esi
    cmp edx, 0      ; daca nu e multiplu de 5, trec la urmatorul element
    jne do_nothing
compute:
    xor ebx, ebx
    mov bx, word [products + 2 * ecx - 2]

    shr ebx, 8      ; caut cel mai semnificativ octet

    test ebx, 1     ; verifica daca e par sau nu
    jnz do_nothing  ; daca e impar, trec mai departe

    mov bx, word [products + 2 * ecx - 2]
    xor ebx, -256   ; fac flip DOAR celui mai semnificativ octet

    mov word [answer + 2*edi - 2], bx
    dec edi
do_nothing:
    loop iterate


;     ;; INSTRUCTIUNI AFISARE subpunct c). NU MODIFICATI!
c_print:
    xor ecx, ecx
c_print_loop:
	PRINTF32 `%hx \x0`, [answer + 2 * ecx]
	inc ecx
	cmp ecx, c_answer_len
	jb c_print_loop
	PRINTF32 `\n\x0`


    ; Return 0.
    xor eax, eax
    leave
    ret
