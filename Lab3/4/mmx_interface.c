#include <stdio.h>

	extern void _ememix (int *a); 

	void ememix (int *a);

	int d[16];
	int i;
	
	int main()
	{
		//d=&c;
		for (i=0;i<16;i++)
			d[i]=0;
		
		ememix(d);
		//printf("%d\n",sizeof(d[0]));
		for (i=0;i<16;i++)
			printf("%d\n", *(d+i));
		return 0;
	}