section .text use32
global _oblicz

_oblicz:
    %idefine a [ebp+8]
    %idefine b [ebp+12]
    %idefine c [ebp+16]
    %idefine d [ebp+20]
    %idefine e [ebp+24]

    push ebp
    mov ebp, esp

    finit
    fld dword a
    fsub dword b  ; a-b
    fabs          ; |a-b|
    fld dword c
    fadd dword d  ; c+d
    fmul st0, st0 ; (c+d)*(c+d)
    fdiv          ; |a-b|/(c+d)^2
    fmul dword e  ; |a-b|/(c+d)^2*e

    leave
    ret
