cpu 386
section .text
org 100h

start:
    xor dx, dx ; zeruje bo potrzebny do gornych bitow dla dodatniej liczby
    mov ax, -32768 ; to jest najmniejsza wartość, maksymalnie 32767

    cmp ax, 0
    jl obsluz_ujemna

    call wypisz_liczbe

obsluz_ujemna:
    mov bx, ax

    mov dl, '-'
    mov ah, 02h
    int 21h

    neg bx
    xor dx, dx ; zeruje po wypisaniu '-', potrzebne do gornych bitow
    mov ax, bx

wypisz_liczbe:
    xor cx, cx
    mov bx, 10 ; dzielnik
    jmp wypisz_cyfry

wypisz_cyfry:
    div bx ; AX = DX:AX/10, DX = DX:AX mod 10
    push dx ; zapisanie na stos żeby później wypisać, interesuje tylko dx
    xor dx, dx ; zeruję resztę

    inc cl ; zapisuję ile jest cyfr
    cmp ax, 0
    jnz wypisz_cyfry
    jz wypisz_cyfry_ze_stosu

wypisz_cyfry_ze_stosu:
    pop bx

    mov dl, bl
    add dl, 30h ; cyfry w ASCII zaczynają się od 30h
    mov ah, 02h
    int 21h

    dec cl
    jnz wypisz_cyfry_ze_stosu
    jmp zakoncz

zakoncz:
    mov ax, 4c00h
    int 21h