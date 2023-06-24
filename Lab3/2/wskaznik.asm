section .text use32

global	_wskaznik

_wskaznik:
	;Tu standardowo tworzymy ramkê stosu
	push	ebp
	mov	ebp, esp
	;WskaŸnik jest argumentem przekazanym przez stos. 
	;[ebp] pokazuje star¹ zawartoœæ ebp
	;[ebp+4] pokazuje adres powrotu
	;[ebp+8] pokazuje adres przekazany do procedury (wskaŸnik)
	mov eax, [ebp+8] ; tu kopiujemy wartoœæ spod adresu przechowywanego w [ebp+8]
	mov ebx, 4
	;[eax] to wartoœæ przechowywana pod adresem [ebp+8]. 
	;Operacja zwiêksza o 1 wartoœæ argumentu przekazanego przez wskaŸnik
	add [eax],ebx
	leave
	
	ret