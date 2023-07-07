cpu 386
section .text
org 100h

start:
    mov dx, podaj_liczby
    mov ah, 09h
    int 21h

    call wczytaj_liczbe
    call konwertuj_liczbe
    call wypisz_nowa_linia

    push ax

    call wczytaj_liczbe
    call konwertuj_liczbe
    call wypisz_nowa_linia

    pop bx
    imul bx

    cmp ax, 0
    jl obsluz_ujemna

    call wypisz_liczbe

wczytaj_liczbe:
    call czysc_bufor
    mov bx, dx
    xor cx, cx
    xor di, di
    mov ah, 0Ah
    int 21h

    xor ax, ax
    inc bx
    mov byte al, [bx] ; ilosc pobranych znakow
    mov cl, al ; ilosc pobranych znakow do iteracji
    inc bx ; pierwszy znak

    mov di, cx ; zapisz ilosc znakow - do konwersji
    mov si, 1 ; liczba dodatnia

    cmp byte [bx], 45 ;'-'
    jz zapisz_ze_ujemna
    jmp ustaw_wskazniki
    ret

czysc_bufor:
    xor cx, cx
    xor ax, ax
    mov byte al, [bufor_dlugosc]
    mov cl, al
    dec cl
    mov bx, bufor_liczba
    mov dx, bx
    xor ax, ax
    mov byte al, [bufor_pierwsza_kom]
    mov [bx], al
    inc bx
    petla_reset_buf:
        mov byte [bx], 0
        inc bx
        loop petla_reset_buf
    ret

zapisz_ze_ujemna:
    neg si
    inc bx
    dec cl
    dec di ; jeden z pobranych znakow to '-', wiec zmniejszam ilosc pobranych znakow do konwersji

ustaw_wskazniki:
    mov dx, bx ; bx ustawiony na pierwsza cyfre
    mov bx, cx
    ret

;dx - pierwsza cyfra, di - ilosc cyfr, si - znak liczby
konwertuj_liczbe:
    xor ax, ax
    mov bx, dx
    mov cx, di
    xor dx, dx
    mov di, 10
    konwertuj_petla:
        mul di
        xor dx, dx
        mov byte dl, [bx]
        sub dl, 48
        add ax, dx
        inc bx
        loop konwertuj_petla
    imul ax, si
    ret

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

wypisz_nowa_linia:
    push ax
    push dx
    mov dx, nowa_linia
    mov ah, 9
    int 21h
    pop dx 
    pop ax
    ret

section .data
    bufor_liczba TIMES 10 db 0
    bufor_dlugosc db 10
    bufor_pierwsza_kom db 7

    podaj_liczby db "Podaj dwie liczby", 10, 13, "$"
    nowa_linia  db   13,10,"$"
