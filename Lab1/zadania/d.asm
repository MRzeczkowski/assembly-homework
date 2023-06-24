section .text
org 100h
start:
	mov dx, msg
	mov ah, 09h
	int 21h
	call nowa_linia
	mov byte [bufor], 64
	mov byte [bufor + 1], 0
	mov dx, bufor
	mov ah, 0Ah
	int 21h
	mov al, [bufor + 1]
	add al, 2
	xor ah, ah 
	mov si, ax 
	mov byte [bufor + si], 0
	call stworz_katalog
	mov	ax, 4C00h
	int	21h
	

stworz_katalog_done:
	ret
	
nowy_kat:
	mov byte [si], 0
	mov dx, bufor + 2
	mov ah, 39h 
	int 21h
	mov byte [si], '\'
	jmp stworz_katalog_loop_2

iteruj_dalej:
	jmp stworz_katalog_loop_2
	
stworz_katalog_loop:
	cmp byte [si], '\'
	jz nowy_kat
	jnz iteruj_dalej
	
stworz_katalog_loop_2:
	inc si
	dec cx
	cmp cx, 0
	jz stworz_katalog_done
	jnz stworz_katalog_loop
	
stworz_katalog: 
	mov cx, [bufor + 1]
	mov si, bufor + 2
	cmp cx, 0
	jnz stworz_katalog_loop
	jz stworz_katalog_done
	
nowa_linia: 
	mov	ah, 2
	mov	dl, 10
	int	21h
	mov	ah, 2
	mov	dl, 13
	int	21h
	ret

section .data
	bufor  	TIMES 63 db 0
	msg		db "Podaj sciezke$"