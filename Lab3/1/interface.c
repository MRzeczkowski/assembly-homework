#include <stdio.h>

	extern int _sum (int a, int b); /* deklarujemy funkcję zewnętrzną */

	int sum (int a, int b);	 /* prototyp funkcji */

	int c=1, d=2;

	int main()
	{  
		printf("%d\n", sum(c,d));
		return 0;
	}
	
	
/**************************************************************************
Jak to skompilować:
1. Najpierw asemblujemy moduł w asemblerze:
nasm procedure.asm -f coff -o procedure.o
2. Teraz łączymy kod C z binarnym obrazem modułu w asemblerze:
gcc interface.c procedure.o -o program.exe
***************************************************************************/