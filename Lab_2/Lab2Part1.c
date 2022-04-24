#include <stdio.h>

int z = 0;

int main(){
  int A = 15; // store a value
  int B = 10; // store a value
  int C = 5;  // store a value
  int D = 2;  // store a value
  int E = 18; // store a value
  int F = -3; // store a value

  z = (A-B);
  // sub rd, rs1, rs2
  z = z + (C*D);
  //two lines
  // and rd, rs1, rs2
  // add rd, rs1, rs2 (where rs2 is previous rd)
  z = z + (E-F);
  //two lines
  // sub rd, rs1, rs2
  // add rd, rs1, rs2 (where rs2 is previous rd)
  z = z - (A/C);
  //two lines
  // slli rd, rs1, shamt
  // sub rd, rs1, rs2 (where rs2 is previous rd)
  printf("z is: %d\n",z);
  /* printf("z is: %5.2f\n",(double)z); */
  return z;
}
