#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <math.h>

extern void _mnozenie_tablic(void* a, void* b, void* wynik, unsigned int dlugosc, unsigned int rozmiar); // deklarujemy funkcję zewnętrzną

void mnozenie_tablic(void* a, void* b, void* wynik, unsigned int dlugosc, unsigned int rozmiar);

int main() {
    unsigned int dlugosc;
    printf("Podaj dlugosc tablic: ");
    scanf("%u", &dlugosc);

    void* a;
    void* b;
    void* wynik;

    unsigned int rozmiar;
    printf("Podaj rozmiar cyfr (1 = char, 2 = short, 4 = int, 8 = long long): ");
    scanf("%u", &rozmiar);

    srand(42);

    switch (rozmiar)
    {
    case 1:
        rozmiar = sizeof(unsigned char);
        a = malloc(dlugosc * rozmiar);
        b = malloc(dlugosc * rozmiar);
        wynik = malloc(dlugosc * rozmiar);

        for (int i = 0; i < dlugosc; i++) {
            ((unsigned char*)a)[i] = (unsigned char)(rand() % 10);
            ((unsigned char*)b)[i] = (unsigned char)(rand() % 10);
        }

        mnozenie_tablic(a, b, wynik, dlugosc, rozmiar);

        for (int i = 0; i < dlugosc; i++) {
            printf("%u * %u = %u\n", ((unsigned char*)a)[i], ((unsigned char*)b)[i], ((unsigned char*)wynik)[i]);
        }

        break;

    case 2:
        rozmiar = sizeof(unsigned short);
        a = malloc(dlugosc * rozmiar);
        b = malloc(dlugosc * rozmiar);
        wynik = malloc(dlugosc * rozmiar);

        for (int i = 0; i < dlugosc; i++) {
            ((unsigned short*)a)[i] = (unsigned short)(rand() % 10);
            ((unsigned short*)b)[i] = (unsigned short)(rand() % 10);
        }

        mnozenie_tablic(a, b, wynik, dlugosc, rozmiar);

        for (int i = 0; i < dlugosc; i++) {
            printf("%u * %u = %u\n", ((unsigned short*)a)[i], ((unsigned short*)b)[i], ((unsigned short*)wynik)[i]);
        }

        break;

    case 4:
        rozmiar = sizeof(unsigned int);
        a = malloc(dlugosc * rozmiar);
        b = malloc(dlugosc * rozmiar);
        wynik = malloc(dlugosc * rozmiar);

        for (int i = 0; i < dlugosc; i++) {
            ((unsigned int*)a)[i] = rand() % 10;
            ((unsigned int*)b)[i] = rand() % 10;
        }

        mnozenie_tablic(a, b, wynik, dlugosc, rozmiar);

        for (int i = 0; i < dlugosc; i++) {
            printf("%u * %u = %u\n", ((unsigned int*)a)[i], ((unsigned int*)b)[i], ((unsigned int*)wynik)[i]);
        }

        break;

        case 8:
        rozmiar = sizeof(unsigned long long);
        a = malloc(dlugosc * rozmiar);
        b = malloc(dlugosc * rozmiar);
        wynik = malloc(dlugosc * rozmiar);

        for (int i = 0; i < dlugosc; i++) {
            ((unsigned long long*)a)[i] = (unsigned long long)(rand() % 10);
            ((unsigned long long*)b)[i] = (unsigned long long)(rand() % 10);
        }

        mnozenie_tablic(a, b, wynik, dlugosc, rozmiar);

        // Wyniki nie są do zawsze poprawne, prawdopodobnie dlatego że unsigned long long zajmuje 64bit'y.
        // To wymagałoby odpowiedniego obsłużenia po stronie procedury w assemblerze.
        for (int i = 0; i < dlugosc; i++) {
            printf("%lli * %lli = %lli\n", ((unsigned long long*)a)[i], ((unsigned long long*)b)[i], ((unsigned long long*)wynik)[i]);
        }

        break;

    default:
        printf("Bledny rozmiar!");
        return 0;
    }

    free(a);
    free(b);
    free(wynik);

    return 0;
}

/**************************************************************************
Jak to skompilować:
1. Najpierw asemblujemy moduł w asemblerze:
nasm procedure.asm -f coff -o procedure.o
2. Teraz łączymy kod C z binarnym obrazem modułu w asemblerze:
i686-w64-mingw32-gcc interface.c procedure.o -o program.exe
***************************************************************************/