;Demonstracja konstrukcji pętli while
section .text
org 100h

start:

	mov bx, 6 ;chcemy iterować 5 razy
	mov	ah, 9 ; funckja systemowa do wypisania napisu
	mov	dx, napis

petla:
	dec	bx
	jz koniec ;jeśli w bx jest zero, wyjdź z pętli
	int	21h
	jmp petla 
koniec: 
	mov	ax, 	4C00h
	int	21h

section .data
	napis	db	"Napis $"