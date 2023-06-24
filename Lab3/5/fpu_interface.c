#include <stdio.h>

	extern int _sum (int a, int b); /* external function declaration */

	int sum (int a, int b);	 /* function prototype */

	int c=9, d=3;

	int main()
	{
		printf("%d\n", sum(c,d));
		return 0;
	}