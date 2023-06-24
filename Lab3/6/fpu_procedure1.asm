section .text use32

	global	_sum

	_sum:
	; po wykonaniu push ebp i mov ebp, esp:
	; [ebp]    old EBP location
	; [ebp+4]  return point from procedure
	; [ebp+8]  the first parameter of the procedure,
	; [ebp+12] the second parameter of the procedure

	%idefine	a	[ebp+8]
	%idefine	b	[ebp+12]

		push	ebp
		mov	ebp, esp

		finit ; inicjalizacja stosu FPU
		fld dword a ;³adowanie pierwszej liczby rzeczywistej pojedynczej precyzji do rejestru st0
		fld dword b ; ³adowanie drugiej liczby rzeczywistej pojedynczej precyzji do rejestru st0, pierwsza jest teraz w st1
		fadd; st0,st1
;		fstp dword [wynik]
;		faddp st1,st0
;		mov eax, [wynik]

	; LEAVE = mov esp, ebp / pop ebp
		leave
		ret