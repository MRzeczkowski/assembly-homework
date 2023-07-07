#include <stdio.h>

extern void _oblicz(double a, double b, double c, double d, double e, double* wynik);

void oblicz(double a, double b, double c, double d, double e, double* wynik);

int main() {
    double a, b, c, d, e;

    printf("Podaj liczby rzeczywiste (a, b, c, d, e): ");
    scanf("%lf %lf %lf %lf %lf", &a, &b, &c, &d, &e);

    double wynik = 0.0;

    oblicz(a, b, c, d, e, &wynik);

    printf("Wynik: %.20lf\n", wynik); // 20 miejsc po przecinku zeby pokazac precyzje
    return 0;
}

/**************************************************************************
Jak to skompilować:
1. Najpierw asemblujemy moduł w asemblerze:
nasm procedure.asm -f coff -o procedure.o
2. Teraz łączymy kod C z binarnym obrazem modułu w asemblerze:
i686-w64-mingw32-gcc interface.c procedure.o -o program.exe
***************************************************************************/