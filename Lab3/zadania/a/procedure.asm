	section .text use32

	global	_mul

	_mul:

	%idefine	a	[ebp+8]
	%idefine	b	[ebp+12]

		push	ebp
		mov	ebp, esp

		mov eax, a ;
		imul eax, b ; operacja mnożenia eax * zmienna b (wrzucamy wynik do eax)

	; LEAVE = mov esp, ebp / pop ebp
		leave
		ret