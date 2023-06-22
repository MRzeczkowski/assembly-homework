;Program demonstrujący aktualizację wartości zmiennej bezpośrednio
section .text
org 100h

start:
	mov	ah, 2 ;Znowu wypisujemy znak na ekranie...
	mov	dl, [liczba]
	int	21h ; Wypisanie znaku przed aktualizacją
	mov byte [liczba], 55 ;aktualizacja bezpośrednio w pamięci (kwalifikator "byte" pokazuje, ile bajtów jest aktualizowanych - tutaj jeden...)
	mov	dl, [liczba] ; Wypisanie znaku po aktualizacji
	int	21h

	mov	ax, 4C00h
	int	21h

section .data
	liczba	dd	3565667h ; Uwaga: to jest za duże na tą zmienną! Co jest wypisywane na ekranie??