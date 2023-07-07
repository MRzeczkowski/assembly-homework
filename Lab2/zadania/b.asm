;Program demonstrujący działanie stosu. Najpierw wrzucamy 5 znaków na stos, a potem je zdejmujemy i pokazujemy na ekranie
cpu 386

section .text
org 100h

mov cx, 5
mov ah, 1

petla:
    int 21h
    movzx bx, al ; Tu upewniam się, że dwa bajty wrzucane na stos mają wartość równą oryginalnej zawartości al
    push bx
    loop petla

mov cx, 5
mov ah, 2

mov bx, sp
add bx, 8

;Odkomentowanie tego spowoduje, że napis zdjęty ze stosu będzie pokazany POD napisem pobranym z klawiatury
;mov dx, 10
;int 21h

petla1:
    mov dx, [bx]
    int 21h
    sub bx, 2
    loop petla1

mov ah, 4ch
int 21h
