section .text use32

global	_ememix

_ememix:

	%define ITERACJE 16 ; deklarujemy liczb� iteracji
	;Tu standardowo tworzymy ramk� stosu
	push	ebp
	mov	ebp, esp
	
	movq mm0, [tablica1] ;�adujemy do pierwszego rejestru 8 bajt�w z tablicy1
	paddb mm0, [tablica2] ;dodajemy do warto�ci rejestru 8 bajt�w z tablicy2
	movq [tablica3], mm0 ;wynik do tablicy3
	mov esi,[ebp+8]
	xor eax,eax
	mov ecx, ITERACJE
przepisz:
	mov bl,[tablica3+eax]
	movzx edx,bl
	mov [esi+eax*4],edx
	inc eax
	loop przepisz
	
	leave
	ret

section .data
	tablica1 times ITERACJE db 41
	tablica2 times ITERACJE db 28 
	tablica3 times ITERACJE db 65	