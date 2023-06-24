section .text
org 100h 

start:
mov dx, pob_licz_str
mov ah, 09h 
int 21h
call nowa_linia
call pobierz_liczbe
call nowa_linia
mov word bx, [pobrana_liczba]
mov dx, pob_licz_str
mov ah, 09h 
int 21h
call nowa_linia
call pobierz_liczbe
call nowa_linia
mov word ax, [pobrana_liczba]
xor dx, dx 
mul bx
mov [liczba_32_h], dx
mov [liczba_32_l], ax
call generuj_iloczyn_32
mov dx, iloczyn_32b
mov ah, 09h
int 21h
call napraw_wyniki


call porownaj_z_70k
call nowa_linia
;xor bx, bx
;mov byte bl, [wynik_porownania]
call wypisz_wynik_porownania

mov	ax, 4C00h
int	21h

napraw_wyniki:
mov bx, [liczba_32_h]
call wart_bezwgl_bx
mov [liczba_32_h], bx
mov bx, [liczba_32_l]
call wart_bezwgl_bx
mov [liczba_32_l], bx
mov ax, 35000
mov bx, 2
mul bx 
mov word [prog_70k_h], dx
mov word [prog_70k_l], ax

neguj_bx: 
	neg bx 
	ret

wart_bezwgl_bx:
	cmp bx, 0
	jl neguj_bx
	ret

wypisz_wynik_porownania:
	mov word dx, wyn_porown_pocz
	mov ah, 09h
	int 21h 
	mov ah, 09h
	mov word dx, iloczyn_32b
	int 21h
	xor bx, bx 
	mov byte bl, [wynik_porownania]
	cmp bx, 2
	jz wypisz_prog_wiekszy
	cmp bx, 1
	jz wypisz_prog_rowny
	jmp wypisz_prog_mniejszy
	
wypisz_prog_wiekszy:
	mov word dx, wynik_porownania_mniejsza
	mov ah, 09h
	int 21h 
	call nowa_linia
	ret 

wypisz_prog_rowny: 
	mov word dx, wynik_porownania_rowna
	mov ah, 09h
	int 21h 
	call nowa_linia
	ret
	
wypisz_prog_mniejszy:
	mov word dx, wynik_porownania_wieksza
	mov ah, 09h
	int 21h 
	call nowa_linia
	ret
	
nowa_linia: 
	mov [nl_tmp_ax], ax 
	mov [nl_tmp_dx], dx
	mov	ah, 2
	mov	dl, 10
	int	21h
	mov	ah, 2
	mov	dl, 13
	int	21h
	mov ax, [nl_tmp_ax]
	mov dx, [nl_tmp_dx]
	ret


reset_buf: 
mov byte dl, [buf_liczba_len]
mov byte [buf_liczba], dl
mov bx, buf_liczba +1
mov byte [bx], 0
inc bx
mov byte [bx], 0
inc bx
mov byte [bx], 0
inc bx
mov byte [bx], 0
inc bx
mov byte [bx], 0
inc bx
mov byte [bx], 0
ret

pobierz_liczbe_done:
mov word [pobrana_liczba], ax 
mov word cx, [tmp_cx] 
mov word ax, [tmp_ax]
mov word dx, [tmp_dx]
mov word bx, [tmp_bx] 
mov word si, [tmp_si]
ret

pobierz_liczbe_loop:
mov cx, 10
mul cx 
xor cx, cx
mov byte cl, [si]
sub cx, 48
add ax, cx 
inc si 
cmp bx, si
jnz pobierz_liczbe_loop
jz pobierz_liczbe_done

pobierz_liczbe:
mov word [tmp_cx], cx 
mov word [tmp_ax], ax
mov word [tmp_dx], dx
mov word [tmp_bx], bx
mov word [tmp_si], si
call reset_buf
mov ah, 0Ah
mov dx, buf_liczba
int 21h
xor ax, ax
;przygotuj zmienne do loopowania po cyfrach
xor bx, bx
mov byte bl, [buf_liczba + 1] ;odczyt ilosci pobranych znakow
add bx, 2 ;jedna komorka dalej niz ostatni pobrany znak
mov dx, buf_liczba
mov si, dx
add si, 2
add dx, bx
mov bx, dx
xor dx, dx

cmp bx, si
jz pobierz_liczbe_done
jnz pobierz_liczbe_loop 

konwertuj_liczbe:
	div di 
	cmp ax, 0x000a
	jl konwertuj_liczbe_010
	jge konwertuj_liczbe_AF

konwertuj_liczbe_2:
	mov byte [si], al
	inc si 
	cmp dx, 0x000a
	jl konwertuj_liczbe_010_2
	jge konwertuj_liczbe_AF_2

konwertuj_liczbe_3: 
	mov byte [si], dl
	inc si 
	ret
	
konwertuj_liczbe_010_2: 
	add dx, 48
	jmp konwertuj_liczbe_3

konwertuj_liczbe_AF_2: 	
	add dx, 55
	jmp konwertuj_liczbe_3
	
konwertuj_liczbe_010:
	add ax, 48
	jmp konwertuj_liczbe_2

konwertuj_liczbe_AF:
	add ax, 55
	jmp konwertuj_liczbe_2


reset_iloczyn:
mov si, iloczyn_32b
mov byte [si], '0'
inc si 
mov byte [si], 'x'
inc si
mov byte [si], 0
inc si
mov byte [si], 0
inc si
mov byte [si], 0
inc si
mov byte [si], 0
inc si
mov byte [si], 0
inc si
mov byte [si], 0
inc si
mov byte [si], 0
inc si
mov byte [si], 0
inc si
mov byte [si], '$'
ret

generuj_iloczyn_32:
	call reset_iloczyn
	mov bx, ax 
	mov cx, dx 
	xor ax, ax 
	xor dx, dx 
	mov di, 16
	mov si, iloczyn_32b + 2
	mov byte al, ch
	call konwertuj_liczbe
	xor ax, ax 
	xor dx, dx
	mov al, cl
	call konwertuj_liczbe
	xor ax, ax
	xor dx, dx
	mov al, bh 
	call konwertuj_liczbe
	xor ax, ax 
	xor dx, dx
	mov al, bl 
	call konwertuj_liczbe
	
	mov byte [si], '$'
	ret


porownaj_z_70k:
mov [tmp_ax], ax
mov [tmp_bx], bx
mov [tmp_cx], cx 
mov [tmp_dx], dx
mov [tmp_si], si 

mov byte [wynik_porownania], 1
mov word ax, [liczba_32_h]
mov word bx, [prog_70k_h]
cmp bx, ax 
jl porownaj_z_70k_input_wiekszy
jg porownaj_z_70k_input_mniejszy
jz porownaj_z_70k_3


porownaj_z_70k_3:
	mov word ax, [liczba_32_l]
	mov word bx, [prog_70k_l]
	cmp bx, ax 
	jl porownaj_z_70k_input_wiekszy
	jg porownaj_z_70k_input_mniejszy
	jz porownaj_z_70k_done
	

porownaj_z_70k_input_wiekszy:
	mov byte [wynik_porownania], 0
	jmp porownaj_z_70k_done
	
porownaj_z_70k_input_mniejszy:
	mov byte [wynik_porownania], 2
	jmp porownaj_z_70k_done

porownaj_z_70k_done:
	mov ax, [tmp_ax]
	mov bx, [tmp_bx]
	mov cx, [tmp_cx]
	mov dx, [tmp_dx]
	mov si, [tmp_si]
	ret



section	.data

pob_licz_str	db "Podaj liczbe mniejsza niz 65536$"
iloczyn_32b 	db 48,120,0,0,0,0,0,0,0,0,'$'
prog_70k_h		dw 1 	
prog_70k_l		dw 4464
liczba_32_h 	dw 0x0000
liczba_32_l		dw 0x0000
wyn_porown_pocz db "Liczba $"
wynik_porownania_mniejsza db " jest mniejsza niz 70000$"
wynik_porownania_rowna db    " jest rowna 70000$"
wynik_porownania_wieksza db  " jest wieksza niz 70000$"
wynik_porownania db 0h

;pobierz_liczbe
tmp_cx dw 0x0000
tmp_ax dw 0x0000
tmp_dx dw 0x0000
tmp_bx dw 0x0000
tmp_si dw 0x0000
buf_liczba TIMES 7 db 0
buf_liczba_len db 8
pobrana_liczba dw 0x0000

;nowa_linia
nl_tmp_ax dw 0x0000
nl_tmp_dx dw 0x0000




