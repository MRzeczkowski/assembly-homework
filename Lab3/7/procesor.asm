; ----------------------------------------------------------------------------
; procesor.asm
;
; Ten program wykorzystuje instrukcjê maszynow¹ CPUID do identyfikacji procesora
; i wypisuje odpowiedni napis na ekranie 
; Kompilacja: nasm -f win32 procesor.asm -o procesor.obj
;	      gcc procesor.obj -m32 -o procesor.exe
; ----------------------------------------------------------------------------

    global  _main
    extern  _printf

    section .text
_main:
	xor eax,eax
	cpuid 
	;Poni¿ej zape³niamy lokalizacjê w pamiêci napisem wstawionym do rejestrów ebx,edx,ecx (w tej kolejnoœci)
	mov [procek],ebx
	mov [procek+4],edx
	mov [procek+8],ecx

    push    procek ; wrzucamy na stos argument wywo³ania
    call    _printf
    add     esp, 4 ;"zdejmujemy" ze stosu argument wywo³ania (po prostu go zapominamy)
    ret
	
	section .bss
procek:
	resd 3 ; rezerwujemy 3 podwójne s³owa (bo napis ma 12 znaków)
	db 10,0