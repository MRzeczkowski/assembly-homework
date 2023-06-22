;Program demostruj�cy przekazywanie parametr�w do procedury
cpu 386

section .text
org 100h

start:

push 3 
push 5 
call sumuj

cmp ax,8
jnz koniec

mov ah,9
mov dx,napis
int 21h

koniec:
mov ah, 4ch  
int 21h 

sumuj: 
	push bp   ; przechowanie BP na stosie, potem BX (ramka stosu)  
	mov bp,sp  
	  ; Teraz bp wskazuje na star� warto�� bp, bp+2 na adres powrotu z procedury 
      ; bp+4 wskazuje liczb� 5, a bp+6 wskazuje na liczb� 3 
	mov ax, [bp + 6] ; �adowanie pierwszej liczby 
	mov bx, [bp + 4] ; �adowanie drugiej liczby 
	add ax,bx ; sumowanie 
	pop bp ;Zdejmujemy star� warto�� bp tak, aby sp pokazywa� znowu adres powrotu 
	ret 

napis db "Wynik jest r�wny 8$"