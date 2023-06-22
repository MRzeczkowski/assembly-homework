;Program demonstrujący, że x86 to procesory cienkokońcowe (little endian)
section .text
org 100h

start:
	mov	ah, 9
	mov	dx, napis
	int	21h
	
	mov	ax, 4C00h
	int	21h

setion .data
	napis dd 0x65746550, 0x75722072, 0x2473656c
	;napis dq 0x7572207265746550, 0x2473656c ; <- to samo, tylko na 8 bajtach