section .text
org 100h
start:

	mov	dx, podajhaslo	
	call drukuj_plus_endl
	call czytaj_ciag_sekret
	call nowa_linia
	call kopiuj_bufor
	mov dx, sprawdzhaslo
	call drukuj_plus_endl
	call czytaj_ciag_sekret 
	call nowa_linia
	call porownaj
	
	mov	ax, 4C00h
	int	21h
	
	
	;test - start
drukuj_niepoprawne:
	mov dx, haslo_niepoprawne
	call drukuj_plus_endl
	ret
	
zakoncz_porown:	
	mov dx, haslo_poprawne
	call drukuj_plus_endl
	ret 

porownaj_l:
	cmp byte al, ah 
	jnz drukuj_niepoprawne
	cmp byte al, 24h
	jz zakoncz_porown
	inc si
	inc di 
	mov byte al, [si]
	mov byte ah, [di]
	jmp porownaj_l
	
porownaj:
	mov bx, haslo
	mov si, bx 
	mov bx, bufor
	mov di, bx
	mov byte al, [si]
	cmp al, 24h
	jz drukuj_niepoprawne
	mov byte ah, [di]
	cmp ah, 24h
	jz drukuj_niepoprawne
	jmp porownaj_l
	
	
	

drukuj_plus_endl:
	mov	ah, 9
	int	21h
	call nowa_linia
	ret


	
nowa_linia: 
	mov	ah, 2
	mov	dl, 10
	int	21h
	mov	ah, 2
	mov	dl, 13
	int	21h
	ret

	
czysc_bufor_l:
	mov bx, si
	add bx, cx
	mov byte [bx], 24h
	inc cx
	cmp di, cx
	jz czysc_bufor_after_loop
	jnz czysc_bufor_l

czysc_bufor:
	mov si, bufor
	mov cx, 0
	mov di, [bufor_max_len]
	cmp di, cx
	jnz czysc_bufor_l
	jz czysc_bufor_after_loop
	
czysc_bufor_after_loop:
	mov bx, bufor_len
	mov word [bx], 0x0000
	ret
	


czytaj_ciag_sekret_after_loop:
	mov [bufor_len], di
	ret

wpisano_enter:
	mov byte [bx], 24h
	jmp czytaj_ciag_sekret_after_loop

czytaj_ciag_sekret_l:
	call czytaj_znak_sekret
	mov dl, [znak]
	mov byte [bx], dl
	cmp dh, dl
	jz wpisano_enter
	inc bx
	inc di
	cmp cx, di
	jz czytaj_ciag_sekret_after_loop
	jnz czytaj_ciag_sekret_l
	

czytaj_ciag_sekret:
	call czysc_bufor
	mov cx, [bufor_max_len]
	mov bx, bufor
	mov di, 0
	mov dh, [carriage_return]
	jmp czytaj_ciag_sekret_l


kopiuj_bufor_after_loop:
	mov al, 24h
	mov byte [bx], al
	ret
	
kopiuj_bufor_l:
	mov byte al, [si]
	mov byte [bx], al
	inc bx
	inc si
	cmp byte [si], 24h
	jz kopiuj_bufor_after_loop
	jnz kopiuj_bufor_l
	
kopiuj_bufor:
	mov si, bufor
	mov bx, haslo
	cmp byte [si], 24h
	jnz kopiuj_bufor_l
	jz kopiuj_bufor_after_loop

czytaj_znak_sekret:
	mov ah, 07h
	int 21h
	mov byte [znak], al
	cmp al, 13
	jnz pisz_gwiazdka
	;mov ah, 02h
	;mov dl, 0x2A
	;int 21h
	ret
	
pisz_gwiazdka:
	mov ah, 02h
	mov dl, 0x2A
	int 21h
	ret

section .data

	sprawdzhaslo db	"Sprawdz haslo$"
	podajhaslo	db	"Podaj haslo$"
	bufor		TIMES 51 db 24h ;--- H
	haslo		TIMES 51 db 24h ; --- $
	bufor_len	dw 0x0000
	;haslo_len 	dw 0x0000
	;haslo_max_len	dw 50
	bufor_max_len	dw 50
	znak			db 'a'
	carriage_return db 13
	adr_docel		dw 0x0000 
	haslo_niepoprawne db "haslo niepoprawne$"
	haslo_poprawne	  db "haslo poprawne$"
	


	