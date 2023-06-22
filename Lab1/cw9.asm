;Program demonstrujący działanie operacji arytmetycznych i skoków warunkowych
section .text
org 100h
start:
	mov bx, 10
	mov cx, [liczba]
	mov ah, 9
	sub cx,bx ; operacja odejmowania
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
	int	21h
	mov	ax, 4C00h
	int	21h

section .data
	mniejsze	db "Wynik jest mniejszy od zera$"
	wieksze		db "Wynik jest wiekszy od zera$"
	rowne		db "Wynik jest rowny zeru$"
	liczba		dw 10