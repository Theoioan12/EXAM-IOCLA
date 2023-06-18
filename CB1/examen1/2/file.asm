extern stdin

extern printf
extern scanf
extern calloc
extern strlen

section .data
str_fmt db '%s', 0
str_fmt_newline db '%s', 10, 0
int_fmt_newline db '%d', 10, 0
N dd 64

section .text
global main

;TODO a: Implementati functia `char* read_string(void)` cu urmatorul comportament:
;   - functia aloca memorie pentru a stoca cel mult `N` octeti initializati cu 0.
;   - functia citeste de la intrarea standard un sir de caractere de dimensiune cel mult `N-1` si il stocheaza in memoria alocata.
;   - functia intoarce adresa de memorie alocata mai sus.
;   - pentru alocarea de memorie se recomanda folosirea functiei `void *calloc(size_t nmemb, size_t size);` din biblioteca standard.
;   - pentru citirea de la intrarea standard se recomanda folosirea functiei `int scanf(const char *format, ...);`

read_string:
    push ebp
    mov ebp, esp

    push dword 1        ; sizeof(char)
    push dword [N]      ; cati biti
    call calloc
    add esp, 8  

    pusha
    
    push eax
    push str_fmt
    call scanf
    add esp, 8

    popa

    leave
    ret


; TODO b: Implementati functia `int is_vowel(char c)` care ne spune daca un caracter este vocala sau nu.
;   - functia intoarce 1 daca caracterul primit ca parametru este vocala si 0 in rest.
;   - vocalele sunt `aeiou`.
;   - puteti folosi functia de biblioteca `strlen` pentru a determina dimensiunea unui sir de caractere.
;   - este garantat ca parametrul de intrare va fi o litera mica a alfabetului englezesc.
is_vowel:
    push ebp
    mov ebp, esp

    xor eax, eax
    mov al, byte [ebp + 8]

    cmp eax, 'a'
    je vowel
    cmp eax, 'e'
    je vowel
    cmp eax, 'i'
    je vowel
    cmp eax, 'o'
    je vowel
    cmp eax, 'u'
    je vowel

    mov eax, 0
    jmp end_b

vowel:
    mov eax, 1
    
end_b:
    leave
    ret


; TODO c: Implementati functia `void replace_vowels(char *s)` care inlocuieste toate vocalele din sirul primit
;   la intrare cu caracterul 'X'
;   - functia va modifica sirul de intrare
;   - sirul de intrare este compus doar din litere mici ale alfabetului englezesc

replace_vowels:
    push ebp
    mov ebp, esp

    pusha

    mov edx, [ebp + 8]      ; string

    push edx
    call strlen
    add esp, 4

    mov ecx, eax    ; lungime sir
    xor edi, edi    ; index

iterate:
    push ecx
    xor ebx, ebx
    mov bl, byte [edx + edi]

    xor eax, eax

    push edx
    push edi

    push ebx
    call is_vowel
    add esp, 4

    pop edi
    pop edx

    cmp eax, 1
    jne skip
    xor eax, eax
    mov al, 'X'
    mov [edx + edi], al
skip:
    inc edi
    pop ecx
    loop iterate

out:
    leave
    ret

;TODO d: Implementati functia `int is_palindrome(char *s)` care ne spune daca un sir este palindrom sau nu.
;   - un sir este palindrom daca citit de la dreapta la stanga sau de la standa la dreapta ramane neschimbat.
;   - functia va intoarce 1 daca sirul este palindrom si 0 in rest
is_palindrome:
    push ebp
    mov ebp, esp

    mov edi, [ebp + 8]

    push edi
    call strlen
    add esp, 4

    mov ecx, eax

    xor esi, esi
check:
    xor edx, edx
    xor ebx, ebx

    cmp esi, ecx
    jge palindrome 

    mov dl, byte [edi + esi]
    mov bl, byte [edi + ecx - 1]

    cmp ebx, edx
    jne not_palindrome

    inc esi
    dec ecx
    jmp check
    

palindrome:
    mov eax, 1
    jmp end_d

not_palindrome:
    mov eax, 0

end_d:
    leave
    ret


main:
    push ebp
    mov ebp, esp

    ; Rulati ./file < input.txt pentru o testare completa

    ; TODO a: Apelati functia `read_string` pentru a citi un sir de caractere de la intrarea standard si afisati-l!
    ; pentru afisare puteti folosi functia `printf`.
    ; ATENTIE: functia `printf` poate sa modifice anumite registre. puteti salva / restaura toate registrele folosind instructiunile `pusha`/`popa`

    call read_string

    pusha

    push eax
    push str_fmt_newline
    call printf
    add esp, 8

    popa

    ; TODO b: Decomentati apelurile functiei `is_vowel` si afisati rezultatul intors. Acesta ne spune daca argumentul este vocala sau nu.

    push 'a'
    call is_vowel
    add esp, 4

    push eax
    push int_fmt_newline
    call printf
    add esp, 8

    push 'b'
    call is_vowel
    add esp, 4

    push eax
    push int_fmt_newline
    call printf
    add esp, 8


    ; TODO c: Citi de la intrarea standard un sir de caractere si apelati functia `replace_vowels` pentru a marca
    ; cu caracterul `X` toate vocalele. Afisati apoi sirul rezultat.

    call read_string

    pusha

    push eax
    call replace_vowels
    add esp, 4

    popa

    push eax
    push str_fmt_newline
    call printf
    add esp, 8
    

    ; TODO d: Testati implementarea functiei `is_palindrome` folosind ca intrare doua siruri de caractere citite de la intrarea standard.
    ; Exemplu:
    ; test #1
    call read_string

    push eax
    call is_palindrome
    add esp, 4

    push eax
    push int_fmt_newline
    call printf ; to print result
    add esp, 8

    ; test #2
    call read_string

    push eax
    call is_palindrome
    add esp, 4

    push eax
    push int_fmt_newline
    call printf ; to print result
    add esp, 8


    ; Return 0.
    xor eax, eax
    leave
    ret
