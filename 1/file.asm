24p
%include "./utils/printf32.asm"
extern printf

section .data

int_arr dd 11, 20, 39, 57, 99, 100, 88, 19, 29, 42
len equ 10
limit dd 3000

section .bss
	res_arr resd len
	counter resd 1  ; reserve space for the count

section .text
global main
; TODO c: Find the largest number from `res_arr` that is strictly smaller than `limit`
main:
	push ebp
	mov ebp, esp

	; Move the offset address of res_arr to esi
	mov esi, res_arr

	; Move the offset address of int_arr to edi
	mov edi, int_arr

	; Loop counter in ecx
	mov ecx, len

calc_loop:
	; Load a 32-bit integer from memory at address contained in edi to eax
	mov eax, [edi]
	
	; Perform the arithmetic operation: res_arr[i] = 65 * int_arr[i] + 7
	imul eax, 65
	add eax, 7

	; Store the result in res_arr
	mov [esi], eax

	; Move to the next integer in res_arr and int_arr
	add esi, 4
	add edi, 4

	; Decrease the loop counter
	loop calc_loop

	; Print the array
	mov ecx, len
	mov edi, res_arr
	xor eax, eax ; Set eax to 0

print_loop:
	mov eax, [edi]
	push eax
	PRINTF32 `%d \x0`, eax
	pop eax
	add edi, 4
	loop print_loop

	; Count the number of elements greater than limit
	mov ecx, len
	mov edi, res_arr
	mov ebx, limit

count_loop:
	mov edx, [edi]
	cmp edx, ebx ; Compare the element to the limit
	jle not_greater ; If the element is less than or equal to limit, skip the increment
	inc eax ; Increment the count
not_greater:
	add edi, 4
	loop count_loop

	; Save the count
	mov [counter], eax

	; Print the count
	mov eax, [counter]
	push eax
	PRINTF32 `\nNumber of elements greater than limit: %d\n\x0`, eax
	pop eax

	; Return 0.
	xor eax, eax
	leave
	ret
