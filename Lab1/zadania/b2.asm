;Program demonstrujący działanie operacji arytmetycznych i skoków warunkowych
section .text
org 100h
start:
    mov ax, [dzielna_lb]
    mov dx, [dzielna_hb]
    mov cx, [dzielnik]
    div cx ; operacja dzielenia, wynik w ax

    mov cx, 1 ; używam rejestru żeby cx żeby zachować ax
    and cx, ax ; sprawdzenie parzystosci, ustawia flagę przed skokami

    jz wynik_parzysty
    jnz wynik_nieparzysty

wynik_parzysty:
    mov cx, parzysty
    jmp spr_prog

wynik_nieparzysty:
    mov cx, nieparzysty
    jmp spr_prog

spr_prog:
    sub ax, [prog]
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
    jmp wypisz

wypisz:
    mov ah, 9
    int 21h
    mov ah, 2
    mov dx, 10
    int 21h
    mov ah, 9
    mov dx, cx
    int 21h
    mov ax, 4C00h
    int 21h

section .data
    mniejsze    db "Wynik jest mniejszy od progu$"
    wieksze     db "Wynik jest wiekszy od progu$"
    rowne       db "Wynik jest rowny progowi$"
    parzysty    db "parzysty$"
    nieparzysty db "nieparzysty$"
    dzielna_lb  dw 830 ; lb - lower bytes
    dzielna_hb  dw 0 ; hb - higher bytes
    dzielnik    dw 10
    prog        dw 90
