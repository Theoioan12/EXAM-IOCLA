%include "printf32.asm"
extern printf

section .bss
	product_answer resw 1
	answer resb 24

section .data
	playlist db 0x42, 0x75, 0x76, 0x45, 0x25, 0x79, 0x54, 0x62, 0x94, 0x35, 0x6D, 0x6E, 0x45, 0x4D, 0x7A, 0x14, 0x25, 0x57, 0x94, 0x4C, 0x55, 0x42, 0x78, 0x4B
	playlist_len equ 24

	answer_len equ 12

section .text
global main

main:
    push ebp
    mov ebp, esp


    ; TODO a:
	; Faceti produsul dintre numarul de caractere din vector mai mici decat 'K'
	; si cel al caracterelor mai mari sau egale decat 'K'.
	; Puneti in product_answer rezultatul. (ATENTIE! product_answer asteapta
	; un word (short).

	mov eax, 0
	mov ebx, 0
	mov ecx, 0
	mov edx, 0
	mov esi, 0 ;;index la vector
loop:
	cmp esi, 24
	je end
	mov al, byte [playlist + esi]
	;mov bl, [eax + esi]

	;PRINTF32 `%d \n\x0`, eax
	cmp eax, 75
	jl maimici
	jmp maimare
maimici:
	inc ecx ;;cate elem mici
	inc esi
	jmp loop
maimare:
	inc edx ;;cate elem mari
	inc esi
	jmp loop
end:
	;PRINTF32 `%d \n\x0`, ecx
	;PRINTF32 `%d \n\x0`, edx
	mov eax, 0
	mov ebx, 0
	mov eax, esi
	mov ebx, edx
	mul ebx
	PRINTF32 `%d \n\x0`, eax
	
	; Instructiune de afisare! NU MODIFICATI!
	a_print:
	PRINTF32 `%d\n\x0`, [product_answer]


    ; TODO b:
	; Pentru fiecare element din playlist, puneti in vectorul answer restul
	; impartirii lui la 41.
	mov eax, 0
	mov ebx, 0
	mov ecx, 0
	mov edx, 0
	mov esi, 0
	mov edi, 0
loop1:
	mov edx, 0
	cmp esi, 24
	je end1
	mov eax, 0
	mov al, byte [playlist + esi]
	mov ebx, 0
	mov ebx, 41
	div ebx
	PRINTF32 `%d \n\x0`, edx
	inc esi
	mov dword [answer+esi], edx
	;inc edi
	jmp loop1
end1:
	;PRINTF32 `%d \x0`, [answer]
	;PRINTF32 `%d \n\x0`, ecx

	; Instructiune de afisare! NU MODIFICATI!
b_print:
	xor ecx, ecx
b_print_loop:
	PRINTF32 `%hhd \x0`, [answer + ecx]
	inc ecx
	cmp ecx, playlist_len
	jb b_print_loop
	PRINTF32 `\n\x0`


    ; TODO c:
	; Pentru elementele de pe indici multiplii de 3 sau de 4, inversati
	; nibbles. Fiecare rezultat va fi pus in vectorul answer.




	; Instructiune de afisare! NU MODIFICATI!
c_print:
	xor ecx, ecx

c_print_loop:
	PRINTF32 `%c\x0`, [answer + ecx]
	inc ecx
	cmp ecx, answer_len
	jb c_print_loop
	PRINTF32 `\n\x0`

    ; Return 0.
    xor eax, eax
    leave
    ret
