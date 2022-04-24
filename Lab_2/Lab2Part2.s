# Working with variables in memory

    .data   # Data declaration section

varA:   .word   10
varB:   .word   15
varC:   .word   6
varZ:   .word   0

.text   # Text declaration section

main:       # Start of code section

# Read variables from memory to registers (option 2)
lw  s0, varA        # Load A
lw  s1, varB        # Load B
lw  s2, varC        # Load C
lw  s3, varZ        # Load Z

#if(A < B && 5 < C)

#check (A < B)
slt t0, s0, s1
beq t0, zero, ElseIf

#check ((C > 5) and &&) or exit
li t1, 5 #addi t0, zero, 5
slt t1, t1, s2 # C > 5
bne t0, t1, ElseIf #if false, done with if, go to else if
li s3, 1 #Z = 1
j Switch

#else if ((A > B) || ((C+1) == 7))

ElseIf:
#else if (A > B)
   slt t1, s1, s0 # if (A > B)
   beq t1, zero, ElIfOR
   li s3, 2 #Z = 2
   j Switch

ElIfOR:
#else if (C+1) == 7 true branch to (beq (c+1), 7, DoIt)
   addi t0, s2, 1
   li t1, 7
   bne t0, t1, Else
   li s3, 2 #Z = 2
   j Switch

Else:
   li s3, 3 #Z = 3

Switch:
   addi t0, zero, 1 # t0 = 1
   #or can I use li t0, 1(?)
   beq s3, t0, Case1
   addi t0, t0, 1
   beq s3, t0, Case2
   addi t0, t0, 1
   beq s3, t0, Case3
   addi t0, t0, 1
   bne s3, t0, Default
   j ExitHard

Case1:
   addi s3, zero, -1 # make Z equal to -1
   j Exit # break out of case

Case2:
   addi s3, zero, -2 # make Z equal to -2
   j Exit # break out of case

Case3:
   addi s3, zero, -3 # make Z equal to -3
   j Exit # break out of case

Default:
   add s3, zero, zero # make Z equal to zero
   j Exit # break out of case

Exit:
   #.string "Program Completed Successfully!"
   li  a7,10       #system call for an exit
   ecall

ExitHard:
   #.string "Program Failed!"
   li  a7,10       #system call for an exit
   ecall

# END OF PROGRAM
