#include <stdio.h>

	extern void _tablica (int *a); 

	void tablica (int *a);

	int b[3];

	int main()
	{
		int i;
		for (i=0;i<3;i++)
			b[i]=0;
		tablica(b);
		printf("%d %d %d\n", *b, *(b+1), *(b+2));
		return 0;
	}