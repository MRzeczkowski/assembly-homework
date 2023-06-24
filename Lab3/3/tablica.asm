section .text use32

global	_tablica

_tablica:
	push	ebp
	mov	ebp, esp

	mov eax, [ebp+8] ; tu kopiujemy warto�� spod adresu przechowywanego w [ebp+8]
	mov ecx,3
	;[eax] to warto�� przechowywana pod adresem [ebp+8]. 
	;Operacja zwi�ksza o 1 warto�� argumentu przekazanego przez wska�nik
	xor edi,edi
	petla:
		add [eax+edi],ecx
		add edi,4
		loop petla
	leave
	ret