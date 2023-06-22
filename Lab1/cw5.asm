;Program demonstrujący arytmetykę na adresach
section .text
org 100h

start:
	mov	ah, 2
	mov	dl, [liczba]  ;Wypisujemy pierwszy bajt
	int	21h 
	mov	dl, [liczba+1] ;Wypisujemy drugi bajt
	int	21h

	mov word [liczba], 5042h ;Tu modyfikujemy od razu dwa bajty!
	mov	dl, [liczba] ;Wypisujemy pierwszy bajt
	int	21h 
	mov	dl, [liczba+1] ;Wypisujemy drugi bajt
	int	21h
	;jmp start ;- to jest skok bezwarunkowy - Po odkomentowaniu będzie działać nieskończona pętla!

	mov	ax, 4C00h
	int	21h

section .data
	liczba	dw	3565h ;w pamięci zapisujemy słowo - w zależności od architektury procesora ułożenie jest albo little- albo big endian