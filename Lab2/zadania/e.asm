cpu 386
section .text
org 100h

ORG 100h

start:

	mov ah, 2ch ; pobierz czas, ch = godzina, cl = minuta, dh = sekunda, dl = milisekunda
	int 21h

	push dx ; sekunda + milisekunda
	push cx ; godzina + minuta

	; używam cx bo nie jest teraz używany do niczego innego
	pop cx ; pobieram godzine i minute ze stosu
	mov dl, ch ; godzina
	call itoa99

	mov ah, 02h
	mov dl, ':'
	int 21h

	mov dl, cl ; minuta
	call itoa99

	mov ah, 02h
	mov dl, ':'
	int 21h

	pop cx ; pobieram sekunde i milisekunde ze stosu
	mov dl, ch ; sekunda
	call itoa99

	mov ah, 02h
	mov dl, '.'
	int 21h

	mov dl, cl ; milisekunda
	call itoa99

	mov ax, 4c00h
	int 21h

;dl = liczba do wyświetlenia (od 0 do 99)
itoa99:
	push bx ; zapisanie rejestrów
	push ax

	xor ax, ax ; zerowanie
	mov al, dl

	mov bl, 10d
	div bl ; AL = AX/10, AH = AX mod 10

	add ax, 3030h ; cyfry w ASCII zaczynają się od 30h

	mov bx, ax ; zapisanie na boku bo ah będzie potrzebne do wypisania

	mov dl, bl
	mov ah, 02h
	int 21h

	mov dl, bh
	int 21h

	pop ax ; przywrócenie rejestrów
	pop bx
	ret