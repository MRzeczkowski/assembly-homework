	; Pierwszy program w asemblerze NASM - w pliku cw1.asm
	;Asemblacja: nasm -o cw1.com -f bin cw1.asm
	;To jest komentarz
	;To jest sekcja kodu
	section .text
	org 100h ;tu adres pocz�tku programu wzgl�dem pocz�tku programu (selektor + deskryptor segmentu na niego wskazuje)

	start:	;To jest etykieta - na razie s�u�y do zupe�nie niczego
		mov	ah, 9
		mov	dx, label	
		int	21h

		mov	ah, 0
		int	16h

		mov	ax, 4C00h
		int	21h

	section .data ; Sekcja danych - w�a�ciwie "sta�ych" (bo mo�na je podmienia�)
	
		label	db	"Pierwszy program w asemblerze.$"

