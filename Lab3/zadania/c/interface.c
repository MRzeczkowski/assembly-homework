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
        rozmiar = sizeof(char);
        a = malloc(dlugosc * rozmiar);
        b = malloc(dlugosc * rozmiar);
        wynik = malloc(dlugosc * rozmiar);

        for (int i = 0; i < dlugosc; i++) {
            ((char*)a)[i] = (char)(rand() % 10);
            ((char*)b)[i] = (char)(rand() % 10);
        }

        mnozenie_tablic(a, b, wynik, dlugosc, rozmiar);

        for (int i = 0; i < dlugosc; i++) {
            printf("%u * %u = %u\n", ((char*)a)[i], ((char*)b)[i], ((char*)wynik)[i]);
        }

        break;

    case 2:
        rozmiar = sizeof(short);
        a = malloc(dlugosc * rozmiar);
        b = malloc(dlugosc * rozmiar);
        wynik = malloc(dlugosc * rozmiar);

        for (int i = 0; i < dlugosc; i++) {
            ((short*)a)[i] = (short)(rand() % 10);
            ((short*)b)[i] = (short)(rand() % 10);
        }

        mnozenie_tablic(a, b, wynik, dlugosc, rozmiar);

        for (int i = 0; i < dlugosc; i++) {
            printf("%u * %u = %u\n", ((short*)a)[i], ((short*)b)[i], ((short*)wynik)[i]);
        }

        break;

    case 4:
        rozmiar = sizeof(int);
        a = malloc(dlugosc * rozmiar);
        b = malloc(dlugosc * rozmiar);
        wynik = malloc(dlugosc * rozmiar);

        for (int i = 0; i < dlugosc; i++) {
            ((int*)a)[i] = rand() % 10;
            ((int*)b)[i] = rand() % 10;
        }

        mnozenie_tablic(a, b, wynik, dlugosc, rozmiar);

        for (int i = 0; i < dlugosc; i++) {
            printf("%u * %u = %u\n", ((int*)a)[i], ((int*)b)[i], ((int*)wynik)[i]);
        }

        break;

        case 8:
        rozmiar = sizeof(long long);
        a = malloc(dlugosc * rozmiar);
        b = malloc(dlugosc * rozmiar);
        wynik = malloc(dlugosc * rozmiar);

        for (int i = 0; i < dlugosc; i++) {
            ((long long*)a)[i] = rand() % 10;
            ((long long*)b)[i] = rand() % 10;
        }

        mnozenie_tablic(a, b, wynik, dlugosc, rozmiar);

        // Wyniki nie są do końca poprawne, pewnie chodzi o to, że long long zajmuje 64bit'y.
        // To wymagałoby odpowiedniego obsłużenia tego po stronie procedury w assemblerze.
        for (int i = 0; i < dlugosc; i++) {
            printf("%lli * %lli = %lli\n", ((long long*)a)[i], ((long long*)b)[i], ((long long*)wynik)[i]);
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