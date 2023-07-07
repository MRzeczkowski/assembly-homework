section .data
    wynik: dq 0.0

section .text use32
global _oblicz

_oblicz:
    %idefine a            [ebp+8]
    %idefine b            [ebp+16]
    %idefine c            [ebp+24]
    %idefine d            [ebp+32]
    %idefine e            [ebp+40]
    %idefine adres_wyniku [ebp+48]

    push ebp
    mov	ebp, esp

    finit
    fld qword a
    fsub qword b        ; odejmowanie b
    fabs                ; |a-b|
    fld qword c
    fadd qword d        ; c + d
    fmul st0, st0       ; (c+d) * (c+d)
    fdiv                ; dzielenie |a-b| przez (c+d)^2
    fmul qword e        ; mnożenie przez e

    mov dword esi, adres_wyniku
    fstp qword [wynik]
    mov dword ebx, [wynik]
    mov dword [esi], ebx
    mov dword ebx, [wynik + 4]
    mov dword [esi + 4], ebx

    leave
    ret