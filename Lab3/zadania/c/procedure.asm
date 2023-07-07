section .text use32
global _mnozenie_tablic

_mnozenie_tablic:
    %idefine a       [ebp+8]
    %idefine b       [ebp+12]
    %idefine wynik   [ebp+16]
    %idefine dlugosc [ebp+20]
    %idefine rozmiar [ebp+24]

    push ebp
    mov ebp, esp

    mov esi, a
    mov edi, b
    mov ebx, wynik
    mov ecx, dlugosc

    petla:
        mov eax, [esi]  ; a[i]
        mul dword [edi] ; a[i]*b[i]

        mov [ebx], eax  ; Zapisanie wynik[i]

        ; i++
        add esi, rozmiar
        add edi, rozmiar
        add ebx, rozmiar

        loop petla      ; Dekrementacja ecx i powtarzamy aż ecx = 0

    leave
    ret
