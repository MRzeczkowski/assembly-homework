#include <stdio.h>

	extern float _sum (float a, float b); /* external function declaration */

	float sum (float a, float b);	 /* function prototype */

	float c=5.4533, d=3.1712;

	int main()
	{
		printf("%f\n", sum(c,d));
		return 0;
	}