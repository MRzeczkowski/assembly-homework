#include <stdio.h>

extern float _oblicz(float a, float b, float c, float d, float e);

float oblicz(float a, float b, float c, float d, float e);

int main() {
    float a, b, e, c, d;

    printf("Podaj liczby rzeczywiste (a, b, c, d, e): ");
    scanf("%f %f %f %f %f", &a, &b, &c, &d, &e);

    printf("Wynik: %.20f\n", oblicz(a, b, c, d, e)); // 20 miejsc po przecinku zeby pokazac precyzje
    return 0;
}

/**************************************************************************
Jak to skompilować:
1. Najpierw asemblujemy moduł w asemblerze:
nasm procedure.asm -f coff -o procedure.o
2. Teraz łączymy kod C z binarnym obrazem modułu w asemblerze:
i686-w64-mingw32-gcc interface.c procedure.o -o program.exe
***************************************************************************/