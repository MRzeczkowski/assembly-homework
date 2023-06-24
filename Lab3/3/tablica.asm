section .text use32

global	_tablica

_tablica:
	push	ebp
	mov	ebp, esp

	mov eax, [ebp+8] ; tu kopiujemy wartoœæ spod adresu przechowywanego w [ebp+8]
	mov ecx,3
	;[eax] to wartoœæ przechowywana pod adresem [ebp+8]. 
	;Operacja zwiêksza o 1 wartoœæ argumentu przekazanego przez wskaŸnik
	xor edi,edi
	petla:
		add [eax+edi],ecx
		add edi,4
		loop petla
	leave
	ret