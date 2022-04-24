#include <stdio.h>

int A=10;
int B=15;
int C=6;
int Z=0;


int main()
{
   // Note: I should be able to change
   // the values of A, B, and C when testing
   // your code, and get correct output each time!
   // (i.e. don't just hardwire your output)

   if(A < B && C > 5)
      Z = 1;
   else if( A > B || ((C+1) == 7))
      Z = 2;
   else
      Z = 3;

   switch(Z)
    {
      case 1:
         Z = -1;
         break;
      case 2:
         Z = -2;
         break;
      case 3:
         Z = -3;
         break;
      default:
         Z = 0;
        break;
    }

    printf("Z is: %d\n",Z);

    return Z;
}
