;Program demostrujący wywołanie dwukrotne procedury
section .text

org 100h

start:
	call wypisanie
	call wypisanie
	mov	ax,4c00h
	int	21h

wypisanie:
	mov ah,1
	int 21h
	mov ah,9
	cmp al,48
	jae szansa_cyfra
	jmp blad
	
	szansa_cyfra:
		cmp al, 57
		jbe cyfra
		jmp blad
	cyfra:
		sub al, 48
		mov cl,al
		mov dx, napis
		petla: 
			int 21h
			loop petla
		ret
	blad:
		mov dx, napisblad
		int 21h
		ret
	
section .data
	napis db "Moj napis.$"
	napisblad db "To nie jest cyfra!$"