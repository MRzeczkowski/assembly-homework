; Program odczytuj�cy z klawiatury napis i wypisuj�cy go.
section .text
org 100h

	mov	ah, 9		; funkcja wy�wietlania na ekran
	mov	dx, jak_masz	
	int	21h		

	mov	ah, 0ah	; funkcja pobierania danych z klawiatury
	mov	dx, imie	
	int	21h		; pobierz dane

	mov	ah, 9
	mov	dx, powitanie
	int	21h		; wy�wietl napis "Cze��"
	mov	dx, imie+2	; adres wpisanych danych
	int	21h		

	mov	ax, 4c00h
	int	21h

	jak_masz	db	"Jak masz na imie? $"
	imie		db 	20	; maksymalna liczba znak�w do pobrania
				db 	0	; tu dostaniemy, ile znak�w pobrano
				times 21 db "$"	; miejsce na dane

	powitanie	db	10, 13, 10, 13, "Czesc $"