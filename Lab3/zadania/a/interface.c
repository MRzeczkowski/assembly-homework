#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <stdbool.h>

extern int _mul (int a, int b);

int mul (int a, int b);

int a, b;

int main()
{
	printf("a = ");

	scanf("%d", &a);

	printf("b = ");

	scanf("%d", &b);

	printf("%d * %d = %d\n", a, b, mul(a,b));

	return 0;
}


/**************************************************************************
Jak to skompilować:
1. Najpierw asemblujemy moduł w asemblerze:
nasm procedure.asm -f coff -o procedure.o
2. Teraz łączymy kod C z binarnym obrazem modułu w asemblerze:
i686-w64-mingw32-gcc interface.c procedure.o -o program.exe
***************************************************************************/