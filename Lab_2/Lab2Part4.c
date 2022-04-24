#include <stdio.h>


int A[5]; // Empty memory region for 5 elements 
int B[5] = {1,2,4,8,16}; 

int main(){ 

  int i;  

  for(i=0; i<5; i++){ 
    A[i] = B[i] - 1; 
    printf("for A[%d] is: %d\n", i, A[i]);
  }  

  i--; 
  printf("i: %d\n", i);
  while(i >= 0){ 
    A[i]=(A[i]+B[i]) * 2; 
    printf("for A[%d] is: %d\n", i, A[i]);
    i--; 
  }
 }
