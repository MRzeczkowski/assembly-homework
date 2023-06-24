; ----------------------------------------------------------------------------
; helloworld.asm
; Jest to program typu "hello world", korzystaj¹cy z biblioteki C
; Kompilacja: nasm -f win32 helloworld.asm
; 	      gcc helloworld.obj -m32 -o program.exe 
; ----------------------------------------------------------------------------

    global  _main
    extern  _printf

    section .text
_main:
    push    message
    call    _printf
    add     esp, 4
    ret
message:
    db  'Hello, World!', 10, 0
