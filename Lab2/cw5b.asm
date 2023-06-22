;Ten program wrzuca na stos znaki wprowadzane z klawiatury dop�ki nie zostanie wci�ni�ty ENTER
;W cx zliczane s� znaki wrzucone na stos. Dzi�ki temu wiadomo, ile ich trzeba zdj�� ze stosu
cpu 386

section .text
org 100h

mov ah,1 ;Funkcja pobierania znak�w z klawiatury
xor cx,cx ;Licznik znak�w

petla_in:
	int 21h ; Pobieramy znak
	cmp al,13 ;Je�li to ENTER, to skaczemy do wypisywania
	je end_insert
	inc cx ;zwi�ksz licznik
	movzx dx,al ;przygotowujemy do wrzucenia dw�ch bajt�w (ale jednego znaku) na stos
	push dx ;na stos
	jmp petla_in
end_insert:
	mov ah,2 ; funkcja wypisywania znak� na ekranie
petla_out:
	pop dx ;zdejmujemy ze stosu (dl b�dzie zawiera� znak, dh zawiera same zera)
	int 21h
	loop petla_out
	
	mov	ax, 4c00h
	int	21h