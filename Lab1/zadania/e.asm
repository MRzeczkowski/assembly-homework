section .text
org 100h

start:
    mov word ax, 350
    mov word bx, 200

    mul bx

    call sprawdz_prog

    mov ax, 4C00h
    int 21h

sprawdz_prog:
    mov word bx, [prog_h]
    cmp dx, bx
    jg wypisz_wiekszy
    jl wypisz_mniejszy
    jz sprawdz_prog_l

sprawdz_prog_l:
    mov word bx, [prog_l]
    cmp ax, bx
    jg wypisz_wiekszy
    jl wypisz_mniejszy
    jz wypisz_rowny

wypisz_mniejszy:
    mov dx, mniejszy
    call wypisz
    ret

wypisz_wiekszy:
    mov dx, wiekszy
    call wypisz
    ret

wypisz_rowny:
    mov dx, rowny
    call wypisz
    ret

wypisz:
    mov ah, 9
    int 21h
    ret

section .data
    mniejszy    db "Wynik mniejszy niz 70000.", 13, 10, "$"
    wiekszy     db "Wynik wiekszy niz 70000.", 13, 10, "$"
    rowny       db "Wynik rowny 70000.", 13, 10, "$"
    prog_h      dw 1
    prog_l      dw 4464
