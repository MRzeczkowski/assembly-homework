;Program demonstrujący działanie operacji arytmetycznych i skoków warunkowych - mnożenie
cpu 8086
use16

section .data
	mniejsze	db "Wynik jest mniejszy od stu$"
	wieksze		db "Wynik jest wiekszy od stu$"
	rowne		db "Wynik jest rowny sto$"
	liczba		dw 10

section .text
org 100h
start:
	mov bl, 10
	mov al, [liczba]
	mul bl ; operacja mnożenia al przez bl. Wynik jest w ax
	;mul bx ;[dx:ax] = ax * bx
	cmp ax, 100
	jg wieksze_od_stu ; skok, gdy flaga znaku wyzerowana
	jl mniejsze_od_stu ; skok, gdy flaga znaku ustawiona
	mov dx, rowne
	jmp wypisz 
wieksze_od_stu:
	mov dx, wieksze
	jmp wypisz
mniejsze_od_stu:
	mov dx, mniejsze
wypisz:
	mov	ah, 9
	int	21h
	mov	ax, 4C00h
	int	21h

