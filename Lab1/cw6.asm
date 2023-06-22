;Program pobierający z klawiatury znak i wypisujący go na ekranie
; W tym celu wykorzystamy dwie funkcje DOSa
section .text
org 100h

start:
	mov	ah,1 ; odczytuje znak z klawiatury i wypisuje na ekran
	;mov	ah,7 ;odczytuje znak z klawiatury bez wypisywania na ekranie
	int	21h
	mov dl, al ; przepisanie znaku do wyświetlenia
	mov	ah, 2 ; wypisanie znaku na ekranie
	int	21h

	mov	ax, 4C00h
	int	21h