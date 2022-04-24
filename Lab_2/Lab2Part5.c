#include <stdio.h>

int a, b, c;

int AddItUp( int n ){
  int i;
  int x = 0;

  for( i = 0; i < n; i++ ){
     x = x + i + 1;
  }

  return x;
}

int main()
{
  int i = 5;
  int j = 10;

  a = AddItUp( i );
  printf("a is: %d\n",a);
  b = AddItUp( j );
  printf("b is: %d\n",b);
  c = a + b;
  printf("c is: %d\n",c);
}
