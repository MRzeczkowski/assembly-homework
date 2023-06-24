#include <stdio.h>

extern void _wskaznik (int *a); 

void wskaznik (int *a);

int *d,c=5;

int main()
{
	d=&c;
	wskaznik(d);
	printf("%d\n", *d);
	printf("%d\n", c);
	return 0;
}