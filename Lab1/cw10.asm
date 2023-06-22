; Program demonstrujący działanie operacji arytmetycznych i skoków warunkowych
; Dodawanie i porównywanie z progiem
cpu 8086
use16
section .data
	mniejsze	db "Wynik jest mniejszy od dwudziestu$"
	wieksze		db "Wynik jest wiekszy od dwudziestu$"
	rowne		db "Wynik jest rowny dwadzieścia$"
	liczba		dw 10

section .text
org 100h
start:
	mov bx, 10
	mov cx, [liczba]
	add cx, bx ; operacja dodawania
	cmp cx, 20 ;Tu trzeba porównać wynik do określonej wartości - cmp to odejmowanie, tylko bez zachowania wyniku, za to z ustawieniem flag
	jg wieksze_od_zera ; skok, gdy flaga znaku wyzerowana
	jl mniejsze_od_zera ; skok, gdy flaga znaku ustawiona
	mov dx, rowne
	jmp wypisz
wieksze_od_zera:
	mov dx, wieksze
	jmp wypisz
mniejsze_od_zera:
	mov dx, mniejsze
wypisz:
	mov	ah, 9 ;Przygotowanie do wypisania na ekranie napisu
	int	21h
	mov	ax, 4C00h
	int	21h

