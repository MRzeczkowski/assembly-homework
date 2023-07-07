    section .text use32
    global    _mnozenie

    _mnozenie:
        %idefine a [ebp+8]
        %idefine b [ebp+12]

        push ebp
        mov ebp, esp

        mov eax, a ;
        imul eax, b ; operacja mnożenia eax * zmienna b (wrzucamy wynik do eax)

        leave
        ret