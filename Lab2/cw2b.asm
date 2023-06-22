;Demonstracja konstrukcji pętli do..while - tym razem z instrukcją LOOP
section .text
org 100h

start:
	mov cx, 5 ;chcemy iterować 5 razy - tu MUSI być rejestr zliczający
	mov	ah, 9
	mov	dx, napis

petla:
	int	21h
	;nie ma dec cx!!
	loop 	petla

	mov	ax, 	4C00h
	int	21h

section .data
	napis	db	"Napis $"