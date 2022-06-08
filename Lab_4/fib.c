#include <stdio.h>



int Fibonacci( int n )
{
	int  value;

	if( n <= 0 ){
		value = 0;
		printf("value0: %d\n",value);
	}
	else if( n == 1 ){
		value = 1;
		printf("value1: %d\n",value);
	}
	else{
		int r = Fibonacci( n - 1 );
		int s = Fibonacci( n - 2 );
		printf("r: %d\n",r);
		printf("s: %d\n",s);
		value = r + s;
		printf("valueV: %d\n",value);
	}
	return value;

}

	int main()
	{
		int a, b, c;

		printf("Starting a\n");
		a = Fibonacci( 2 );
		printf("a: %d\n",a);
		printf("-------------------------------------------------------\n");
		//printf("Starting b\n");
		//b = Fibonacci( 10 );
	//	printf("b: %d\n",b);
		//printf("-------------------------------------------------------\n");

	//	printf("Starting c\n");
	//	c = Fibonacci( 20 );
	//	printf("c: %d\n",c);

		return 0;
		}
