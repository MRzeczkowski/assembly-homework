section .text use32
global _cpuid

_cpuid:
    %idefine arg   [ebp+8]
    %idefine wynik [ebp+12]

    push ebp
    mov ebp, esp

    ; Pobierz informacje
    mov eax, arg
    cpuid

    ; Zapisz wyniki do tablicy
    mov edi, wynik
    mov [edi], eax
    mov [edi+4], ebx
    mov [edi+8], ecx
    mov [edi+12], edx

    leave
    ret
