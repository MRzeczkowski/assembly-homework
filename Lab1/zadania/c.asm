section .text
org 100h
start:
	mov	dx, podaj_haslo
	call wypisz

	call wpisz_znaki_do_bufora
	call wypisz_nowa_linia

	call kopiuj_bufor

	mov dx, powtorz_haslo
	call wypisz

	call wpisz_znaki_do_bufora
	call wypisz_nowa_linia

	call porownaj

	mov	ax, 4C00h
	int	21h

wypisz:
	mov	ah, 9
	int	21h
	ret

wypisz_nowa_linia:
	mov	dx, nowa_linia
	call wypisz
	ret

wpisz_znaki_do_bufora:
	call wyczysc_bufor
	mov cx, [bufor_max_len]
	mov bx, bufor
	mov di, 0
	mov dh, 13
	jmp wpisz_znaki_do_bufora_petla

wyczysc_bufor:
	mov si, bufor
	mov cx, 0
	mov di, [bufor_max_len]
	cmp di, cx
	jnz wyczysc_bufor_petla
	jz wyczysc_bufor_zakoncz

wyczysc_bufor_petla:
	mov bx, si
	add bx, cx
	mov byte [bx], 24h
	inc cx
	cmp di, cx
	jnz wyczysc_bufor_petla
	jz wyczysc_bufor_zakoncz

wyczysc_bufor_zakoncz:
	mov bx, bufor_len
	mov word [bx], 0x0000
	ret

wpisz_znaki_do_bufora_petla:
	call czytaj_znak
	mov dl, [znak]
	mov byte [bx], dl
	cmp dh, dl
	jz wpisano_enter
	inc bx
	inc di
	cmp cx, di
	jnz wpisz_znaki_do_bufora_petla
	jz wpisz_znaki_do_bufora_zakoncz

czytaj_znak:
	mov ah, 07h ; no echo
	int 21h
	mov byte [znak], al
	cmp al, 13
	jnz pisz_gwiazdka
	ret

pisz_gwiazdka:
	mov ah, 02h
	mov dl, 0x2A
	int 21h
	ret

wpisano_enter:
	mov byte [bx], 24h
	jmp wpisz_znaki_do_bufora_zakoncz

wpisz_znaki_do_bufora_zakoncz:
	mov [bufor_len], di
	ret

kopiuj_bufor:
	mov si, bufor
	mov bx, haslo
	cmp byte [si], 24h
	jnz kopiuj_bufor_petla
	jz kopiuj_bufor_zakoncz

kopiuj_bufor_petla:
	mov byte al, [si]
	mov byte [bx], al
	inc bx
	inc si
	cmp byte [si], 24h
	jnz kopiuj_bufor_petla
	jz kopiuj_bufor_zakoncz

kopiuj_bufor_zakoncz:
	mov al, 24h
	mov byte [bx], al
	ret

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
	jmp porownaj_petla

drukuj_niepoprawne:
	mov dx, haslo_niepoprawne
	call wypisz
	ret

porownaj_petla:
	cmp byte al, ah
	jnz drukuj_niepoprawne
	cmp byte al, 24h
	jz porownaj_zakoncz
	inc si
	inc di
	mov byte al, [si]
	mov byte ah, [di]
	jmp porownaj_petla

porownaj_zakoncz:
	mov dx, haslo_poprawne
	call wypisz
	ret

section .data
	podaj_haslo			db	"Podaj haslo: $"
	powtorz_haslo 		db	"Powtorz haslo: $"
	nowa_linia 			db	13,10,"$"
	bufor				TIMES 51 db 24h
	bufor_len			dw 0x0000
	bufor_max_len		dw 50
	haslo				TIMES 51 db 24h
	znak				db 'a'
	haslo_poprawne		db "Haslo poprawne.$"
	haslo_niepoprawne 	db "Haslo niepoprawne!$"
