section .text
org 100h
start:
    mov dx, podaj_sciezke
    call wypisz
    call wypisz_nowa_linia

    mov byte [bufor], 64
    mov byte [bufor + 1], 0
    mov dx, bufor
    mov ah, 0Ah
    int 21h

    mov al, [bufor + 1]
    add al, 2
    xor ah, ah 
    mov si, ax 
    mov byte [bufor + si], 0

    call utworz_katalog

    mov ax, 4C00h
    int 21h

wypisz:
    mov ah, 9
    int 21h
    ret

wypisz_nowa_linia:
    mov dx, nowa_linia
    call wypisz
    ret

utworz_katalog: 
    mov cx, [bufor + 1]
    mov si, bufor + 2
    cmp cx, 0
    jnz utworz_katalog_petla
    ret

utworz_katalog_petla:
    cmp byte [si], '\'
    jz nowy_kat
    jmp przesun_indeksy

nowy_kat:
    mov byte [si], 0
    mov dx, bufor + 2
    mov ah, 39h 
    int 21h
    mov byte [si], '\'

przesun_indeksy:
    inc si
    dec cx
    cmp cx, 0
    jnz utworz_katalog_petla
    ret

section .data
    bufor         TIMES 63 db 0
    podaj_sciezke db "Podaj sciezke: $"
    nowa_linia    db    13,10,"$"
