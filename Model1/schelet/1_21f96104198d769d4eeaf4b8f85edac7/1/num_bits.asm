%include "utils/printf32.asm"
dadada
SCHIMBARE
CEVAAUFDADISUFJDASHFLJASDLKFIJ
DKASIHGDFIKADSFJKHGADSKJHFASJHD
section .data
    arr1 db 0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff, 0x99, 0x88
    len1 equ $-arr1
    arr2 db 0x12, 0x34, 0x56, 0x78, 0x90, 0xab, 0xcd, 0xef
    len2 equ $-arr2
    val1 dd 0xabcdef01
    val2 dd 0x62719012
    sign db "sign bit", 0
    no_sign db "no sign bit", 0


section .text
global main
extern printf

main:
    push ebp
    mov ebp, esp

    ; TODO a: Print if sign bit is present or not.
    mov eax, [val1]
    push eax

    shr eax, 31
    cmp eax, 1
    jne no
    PRINTF32 `%s\n\x0`, sign
    jmp skip
no:
    PRINTF32 `%s\n\x0`, no_sign
skip:
    pop eax


    ; TODO b: Prin number of bits for integer value.
    xor ecx, ecx
while:
    cmp eax, 0
    je finish
    test eax, 1
    jz do_not_count
    inc ecx
do_not_count:
    shr eax, 1
    jmp while
finish:
    PRINTF32 `%d\n\x0`, ecx

    ; TODO c: Prin number of bits for array.
    mov esi, arr1
    mov ecx, len1
    xor edx, edx    ; aici pun nr de biti
iterate:
    xor ebx, ebx
    mov bl, byte [esi]

while_mic:
    cmp ebx, 0
    je gata_elementul
    test ebx, 1
    jz ignore
    inc edx
ignore:
    shr ebx, 1
    jmp while_mic

gata_elementul:
    inc esi
    loop iterate

    PRINTF32 `%d\n\x0`, edx


    ; Return 0.
    xor eax, eax
    leave
    ret
