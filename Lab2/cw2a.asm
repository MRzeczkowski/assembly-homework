;Demonstracja konstrukcji pętli typu do..while
section .text
org 100h

start:

mov bx, 5 ;chcemy iterować 5 razy
mov	ah, 9 ; funkcja systemowa do wypisania napisu
mov	dx, napis

petla:
	int	21h
	dec	bx
	jnz petla ;jeśli w bx nie ma zera, kontynuuj pętlę

mov	ax, 	4C00h
int	21h

napis	db	"Napis $"