;Program demostrujący działanie procedury
section .text
org 100h

; Pętla główna programnu
start:
	call procedure ;wywołanie procedury
	mov	ax,4c00h
	int	21h

procedure: ;początek procedury
	mov dl, 5
	mov bl, 48
	add dl, bl
	mov ah, 2
	int 21h
	ret ;koniec procedury