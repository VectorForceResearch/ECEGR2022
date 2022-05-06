#include <stdio.h>

int Fibonacci( int n );

int main()
{
	int a, b, c;

	a = Fibonacci( 3 );
	printf("\nvalue: %d\n",a);
	b = Fibonacci( 10 );
	printf("\nvalue: %d\n",b);
	c = Fibonacci( 20 );
	printf("\nvalue: %d\n",c);
	}

int Fibonacci( int n )
{
	int  value;

	if( n <= 0 ){
		value = 0;
		//printf("\nvalue: %d\n",value);
	}
	else if( n == 1 ){
		value = 1;
		//printf("value: %d\n",value);
	}
	else{
		value = Fibonacci(n - 1) + Fibonacci(n - 2);
		//printf("value: %d\n",value);
	}
	return value;
}
