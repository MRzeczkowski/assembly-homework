section .text
org 100h
start:
    mov bx, [liczba]
    mov ax, 9
    mul bx ; operacja mnożenia
    sub ax, [prog] ; operacja odejmowania
    jg wieksze_od_zera ; skok, gdy flaga znaku wyzerowana
    jl mniejsze_od_zera ; skok, gdy flaga znaku ustawiona
    jz zero ; skok, gdy flaga zera ustawiona
wieksze_od_zera:
    mov dx, wieksze
    jmp wypisz
mniejsze_od_zera:
    mov dx, mniejsze
    jmp wypisz
zero:
    mov dx, rowne
wypisz:
    mov ah, 9
    int 21h
    mov ax, 4C00h
    int 21h

section .data
    mniejsze db "Wynik jest mniejszy od progu$"
    wieksze  db "Wynik jest wiekszy od progu$"
    rowne    db "Wynik jest rowny progowi$"
    liczba   dw 10
    prog     dw 90
