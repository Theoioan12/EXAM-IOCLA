24p
%include "./utils/printf32.asm"
extern printf

section .data

int_arr dd 11, 20, 39, 57, 99, 100, 88, 19, 29, 42
len equ 10
limit dd 3000

section .bss
; TODO a: Reserve space for an array of `len` integers. The array name is `res_arr`
	res_arr resd len

section .text
global main

main:
	push ebp
	mov ebp, esp
	; TODO a: Fill in the first `len` elements of `res_array` using the folloing formula:
	; res_arr[i] = 65 * int_arr[i] + 7
	; Print res_arr with all elements on the same line separated by a space
	mov esi, res_arr

	
	mov edi, int_arr

	; loop coutner
	mov ecx, len

calc_loop:
	; 32 bit in eax 
	mov eax, [edi]
	
	; operatie 
	imul eax, 65 ; imul = integer multiplication
	add eax, 7

	; stocheaza rez
	mov [esi], eax

	; continua cu urmatoarele 
	add esi, 4
	add edi, 4

	; decrease din loop
	loop calc_loop

	; print
	mov ecx, len
	mov edi, res_arr

print_loop:
	mov eax, [edi]
	PRINTF32 `%d\n\x0`, eax
	add edi, 4
	loop print_loop
	
	; Return 0.
	xor eax, eax
	leave
	ret
; TODO a : afiseaza 722 = 65 * 11 + 7; 1307 = 65 * 20 + 7 etc