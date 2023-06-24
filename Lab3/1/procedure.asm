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

		mov	eax, a
		add	eax, b

	; LEAVE = mov esp, ebp / pop ebp
		leave
		ret