cpu 386
section .text
org 100h

ORG 100h

start:
	mov ax, 354
	call wypisz_liczbe

wypisz_liczbe:
    xor cx, cx
    mov bl, 10d ; dzielnik
	jmp wypisz_cyfry

wypisz_cyfry:
	div bl ; AL = AX/10, AH = AX mod 10
    push ax ; zapisanie na stos żeby później wypisać, interesuje tylko al
    xor ah, ah ; zeruję resztę

    inc cl ; zapisuję ile jest cyfr
    cmp al, 0
    jnz wypisz_cyfry
    jz wypisz_cyfry_ze_stosu

wypisz_cyfry_ze_stosu:
    pop bx

	mov dl, bh
    add dl, 30h ; cyfry w ASCII zaczynają się od 30h
	mov ah, 02h
	int 21h

    dec cl
    jnz wypisz_cyfry_ze_stosu
    jmp zakoncz

zakoncz:
	mov ax, 4c00h
	int 21h