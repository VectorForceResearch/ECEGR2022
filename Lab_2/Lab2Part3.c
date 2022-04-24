#include <stdio.h>

int Z=2;
int i;

int main()
{
   printf("start i is: %d\n",i);
   printf("start Z is: %d\n",Z);

   for(i=0; i<=20; ){
      Z++;
      i=i+2;
      printf("for i is: %d\n",i);
      printf("for Z is: %d\n",Z);
   }
   printf("post-for i is: %d\n",i);
   printf("post-for Z is: %d\n",Z);

   do {Z++;} while(Z < 100);

   printf("post-do i is: %d\n",i);
   printf("post-do Z is: %d\n",Z);

   while(i > 0){
      Z--;
      i--;
   }
   printf("end i is: %d\n",i);
   printf("end Z is: %d\n",Z);

   return Z;
}
