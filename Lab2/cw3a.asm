;To jest program, który wypisuje na ekranie liczbę znaków z 
; napisu ćwiczebnego podaną jako argument wywołania
;Demonstrujemy tu indeksowanie
section .text
org 100h

start:
	mov	ah, 1
	int	21h
	cmp al, 48
	jae szansa_cyfra
	jmp blad
szansa_cyfra:
	cmp al, 57
	jbe cyfra
	jmp blad
cyfra:
	sub al, 48 ;robimy ze znaku ASCII cyfrę
	xor cx, cx
	mov cl, al
	mov	ah, 2
	xor di, di
petla:
	mov	dl, [napis+di]
	int	21h
	inc di
	loop petla
	jmp koniec
blad:
	mov ah, 9
	mov dx, napisblad
	int 21h
koniec:
	mov	ax, 4C00h
	int	21h

section .data
	napis	db	"To jest napis cwiczebny $"
	napisblad db "To nie jest cyfra!$"