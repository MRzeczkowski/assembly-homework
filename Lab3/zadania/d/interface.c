#include <stdio.h>
#include <stdint.h>

extern void _cpuid(unsigned int eax, unsigned int* wartosci_rejestrow);

void cpuid(unsigned int eax, unsigned int* wartosci_rejestrow);

void main()
{
    unsigned int wartosci_rejestrow[4]; // eax, ebx, ecx, edx

    cpuid(0, wartosci_rejestrow);
    printf(
        "Producent: %.4s%.4s%.4s\n", // 12 znakow ASCII
        (char*)&wartosci_rejestrow[1],
        (char*)&wartosci_rejestrow[3],
        (char*)&wartosci_rejestrow[2]);

    cpuid(1, wartosci_rejestrow);
    printf("Model: %d\n", (wartosci_rejestrow[0] >> 4) & 0xF); // bity 4-7
    printf("Typ procesora: %d\n", (wartosci_rejestrow[0] >> 12) & 0x3); // bity 12-13

    // Ponizszy wynik nalezy zinterpretowac zgodnie z opisem w tej tabeli - https://www.felixcloutier.com/x86/cpuid#tbl-3-12
    cpuid(2, wartosci_rejestrow);
    printf(
        "Cache i TLB: %X%X%X%X",
        wartosci_rejestrow[0],
        wartosci_rejestrow[1],
        wartosci_rejestrow[2],
        wartosci_rejestrow[3]);
}

/**************************************************************************
Jak to skompilować:
1. Najpierw asemblujemy moduł w asemblerze:
nasm procedure.asm -f coff -o procedure.o
2. Teraz łączymy kod C z binarnym obrazem modułu w asemblerze:
i686-w64-mingw32-gcc interface.c procedure.o -o program.exe
***************************************************************************/