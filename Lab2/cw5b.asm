;Ten program wrzuca na stos znaki wprowadzane z klawiatury dopóki nie zostanie wciœniêty ENTER
;W cx zliczane s¹ znaki wrzucone na stos. Dziêki temu wiadomo, ile ich trzeba zdj¹æ ze stosu
cpu 386

section .text
org 100h

mov ah,1 ;Funkcja pobierania znaków z klawiatury
xor cx,cx ;Licznik znaków

petla_in:
	int 21h ; Pobieramy znak
	cmp al,13 ;Jeœli to ENTER, to skaczemy do wypisywania
	je end_insert
	inc cx ;zwiêksz licznik
	movzx dx,al ;przygotowujemy do wrzucenia dwóch bajtów (ale jednego znaku) na stos
	push dx ;na stos
	jmp petla_in
end_insert:
	mov ah,2 ; funkcja wypisywania znakó na ekranie
petla_out:
	pop dx ;zdejmujemy ze stosu (dl bêdzie zawiera³ znak, dh zawiera same zera)
	int 21h
	loop petla_out
	
	mov	ax, 4c00h
	int	21h