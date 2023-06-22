;Program demonstrujący działanie operacji arytmetycznych i skoków warunkowych - dzielenie
section .data
	w_mniejszy	db "Wynik jest mniejszy od 5$"
	w_wiekszy	db "Wynik jest wiekszy od 5$"
	w_rowny		db "Wynik jest rowny 5$"
	r_mniejsza	db "Reszta jest mniejsza od 4$"
	r_wieksza	db "Reszta jest wieksza od 4$"
	r_rowna		db "Reszta jest rowna 4$"
	liczba		dw 10

section .text
org 100h
start:
	mov bl, 10
	mov ax, [liczba]
	div bl ; AX/BL = AL, AX%BL = AH
	mov cx, ax
	cmp cl, 5
	jg wieksze_od_5 ; skok, gdy flaga znaku wyzerowana
	jl mniejsze_od_5
	mov dx, w_rowny
	jmp wypisz_wynik
wieksze_od_5:
	mov dx, w_wiekszy
	jmp wypisz_wynik
mniejsze_od_5:
	mov dx, w_mniejszy
wypisz_wynik:
	mov	ah, 9	
	int	21h
	
	cmp ch, 4
	jg wieksze_od_4 ; skok, gdy flaga znaku wyzerowana
	jl mniejsze_od_4
	mov dx, r_rowna
	jmp wypisz_reszte
wieksze_od_4:
	mov dx, r_wieksza
	jmp wypisz_reszte
mniejsze_od_4:
	mov dx, r_mniejsza
	
wypisz_reszte:
	;mov	ah, 9
	int	21h
; Koniec programu
	mov	ax, 4C00h
	int	21h
