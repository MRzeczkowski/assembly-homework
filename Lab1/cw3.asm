;Program przepisujący wartość z pamięci do rejestru
section .text
org 100h

start:
	mov	ah, 2 ;Funkcja DOS-a wypisująca na ekranie jeden znak
	mov	dl, [zmienna] ;odwołanie się do wartości spod adresu, na który wskazuje zmienna "zmienna"
	int	21h
	
	mov	ax, 4C00h
	int	21h

section .data
	zmienna db 55