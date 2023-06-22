;To jest modyfikacja programu wypisującego na ekranie liczbę znaków z 
; napisu ćwiczebnego podaną jako argument wywołania - tym razem od końca
cpu 386
section .text
org 100h

start:
	mov	ah, 1
	int	21h
	cmp al, 48
	je koniec ; jeśli to jest '0', to nie wypisujemy żadnego znaku
	ja szansa_cyfra
	jmp blad
szansa_cyfra:
	cmp al, 57
	jbe cyfra
	jmp blad
cyfra:
	sub al, 48 ;zamieniamy znak ASCII na prawdziwą cyfrę
	mov	ah, 2
	
	;xor bx,bx
	;mov bl,al
	;mov di,bx
	
	movzx di, al ;kopiujemy zawartość rejestru 8-bitowego do 16-bitowego
petla:
	mov	dl, [napis+di]
	int	21h
	dec di
	jnz petla
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