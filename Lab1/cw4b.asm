;Program demonstrucjący aktualizację wartości zmiennej za pośrednictwem rejestru
section .text
org 100h

start:
	mov	ah, 2
	mov	dl, [liczba]
	int	21h ; Wypisanie znaku przed aktualizacją
	mov bl, 55 ;aktualizacja z wykorzystaniem rejestru bl
	mov [liczba], bl ; Tu już nie potrzeba kwalifikatora "byte", bo bl zajmuje dokładnie jeden bajt, więc wiadomo, ile danych się kopiuje
	mov	dl, [liczba] ; Wypisanie znaku po aktualizacji
	int	21h
	mov	ax, 4C00h
	int	21h

section .data
	liczba		dd	3565667h 