section .text use32

global	_wskaznik

_wskaznik:
	;Tu standardowo tworzymy ramk� stosu
	push	ebp
	mov	ebp, esp
	;Wska�nik jest argumentem przekazanym przez stos. 
	;[ebp] pokazuje star� zawarto�� ebp
	;[ebp+4] pokazuje adres powrotu
	;[ebp+8] pokazuje adres przekazany do procedury (wska�nik)
	mov eax, [ebp+8] ; tu kopiujemy warto�� spod adresu przechowywanego w [ebp+8]
	mov ebx, 4
	;[eax] to warto�� przechowywana pod adresem [ebp+8]. 
	;Operacja zwi�ksza o 1 warto�� argumentu przekazanego przez wska�nik
	add [eax],ebx
	leave
	
	ret