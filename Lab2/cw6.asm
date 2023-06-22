;Program demostruj¹cy przekazywanie parametrów do procedury
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
	  ; Teraz bp wskazuje na star¹ wartoœæ bp, bp+2 na adres powrotu z procedury 
      ; bp+4 wskazuje liczbê 5, a bp+6 wskazuje na liczbê 3 
	mov ax, [bp + 6] ; ³adowanie pierwszej liczby 
	mov bx, [bp + 4] ; ³adowanie drugiej liczby 
	add ax,bx ; sumowanie 
	pop bp ;Zdejmujemy star¹ wartoœæ bp tak, aby sp pokazywa³ znowu adres powrotu 
	ret 

napis db "Wynik jest równy 8$"