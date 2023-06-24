; ----------------------------------------------------------------------------
; procesor.asm
;
; Ten program wykorzystuje instrukcj� maszynow� CPUID do identyfikacji procesora
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
	;Poni�ej zape�niamy lokalizacj� w pami�ci napisem wstawionym do rejestr�w ebx,edx,ecx (w tej kolejno�ci)
	mov [procek],ebx
	mov [procek+4],edx
	mov [procek+8],ecx

    push    procek ; wrzucamy na stos argument wywo�ania
    call    _printf
    add     esp, 4 ;"zdejmujemy" ze stosu argument wywo�ania (po prostu go zapominamy)
    ret
	
	section .bss
procek:
	resd 3 ; rezerwujemy 3 podw�jne s�owa (bo napis ma 12 znak�w)
	db 10,0