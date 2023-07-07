;Program zamieniający małe litery na wielkie i vice versa
section .text
org 100h

start:
    mov ah, 1 ;pobranie znaku z klawiatury
    int 21h

    cmp al, 13 ; CR - Enter to zwykle połącznie CR i LF, ale Linux często stosuje tylko LF
    je koniec

    cmp al, 10 ; LF
    je koniec

    cmp al, 65
    jae szansa_wielka ;Czy znak >=65? 
    mov dx, blad ; Jeśli nie, to to nie jest litera
    jmp wypisz_blad ; skok do wypisania błędu
szansa_wielka:
    cmp al, 90 ; czy znak <= 90?
    jbe wielka
    cmp al, 97
    jae szansa_mala ; czy znak >= 97? 
    mov dx, blad ; jeśli nie, to to nie jesy ;litera
    jmp wypisz_blad
szansa_mala:
    cmp al,122
    jbe mala ; czy znak <= 122?
    mov dx, blad
    jmp wypisz_blad
mala:
    sub al, 32
    xor dx, dx
    mov dl,al
    jmp wypisz
wielka:
    add al, 32
    xor dx, dx
    mov dl,al
    jmp wypisz
wypisz:
    mov ah, 2
    int 21h
    jmp start
wypisz_blad:
    mov ah, 9
    int 21h
koniec:
    mov ax, 4C00h
    int 21h

blad db "To nie jest litera$"
