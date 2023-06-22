; Drugi program w asemblerze. Demonstruje on deklaracje różnych typów danych
section .text
org 100h

start:
	;I od razu wychodzimy...
	mov	ax, 4C00h
	int	21h

section .data
	info			db	's'
	slowo 			dw 3456h, 300 ; 2-bajtowe liczby calkowite
	liczba			dd	0x3565667	; 4-bajtowa liczba całkowita
	tablica			db	11, 22, 33, 44, 55, 66
	liczba_pi 		dd  3.14
	liczba_e		dq 	2.71	;liczba zmiennoprzecinkowa podwójnej precyzji
	zmienna			TIMES	 16	db	49 ;tablica 16 49-tek
	szesnastkowo	db	0FFh		   
	binarnie		db 10101110b

section .bss
	nie_init	resb 	1 ;To powinno być raczej w sekcji bss