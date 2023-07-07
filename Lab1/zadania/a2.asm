section .text
org 100h ;tu adres poczatku programu wzgledem poczatku programu (selektor + deskryptor segmentu na niego wskazuje)

start: ;To jest etykieta - na razie sluzy do zupelnie niczego
    mov ah, 9
    mov dx, label
    int 21h

    mov ah, 0
    int 16h

    mov ax, 4C00h
    int 21h

section .data ; Sekcja danych - wlasciwie "stalych" (bo mozna je podmieniac)
    label db 77, 97, 116, 101, 117, 115, 122, 10, 82, 122, 101, 99, 122, 107, 111, 119, 115, 107, 105, 36
