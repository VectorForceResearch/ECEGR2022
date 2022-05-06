# Working with variables in memory

    .data   # Data declaration section

varA:   .word   10
varB:   .word   15 #test with 9
varC:   .word   6 #test with 4
varZ:   .word   0

.text   # Text declaration section

main:       # Start of code section

# Read variables from memory to registers (option 2)
lw  a2, varA        # Load A
lw  a3, varB        # Load B
lw  a4, varC        # Load C
la  s11, varZ        # Load Z

#if(A < B && 5 < C)

#check (A < B)
slt t0, a2, a3
beq t0, zero, ElseIf #

#check ((C > 5) and &&) or exit
li t1, 5 #addi t0, zero, 5
slt t1, t1, a4 # C > 5
bne t0, t1, ElseIf #if false, done with if, go to else if
li a5, 1 #Z = 1
j Switch

#else if ((A > B) || ((C+1) == 7))

ElseIf:
#else if (A > B)
   slt t1, a3, a2 # if (A > B)
   beq t1, zero, ElIfOR
   li a5, 2 #Z = 2
   j Switch

ElIfOR:
#else if (C+1) == 7 true branch to (beq (c+1), 7, DoIt)
   addi t0, a4, 1
   li t1, 7
   bne t0, t1, Else
   li a5, 2 #Z = 2
   j Switch

Else:
   li a5, 3 #Z = 3

Switch:
   addi t0, zero, 1 # t0 = 1
   #or can I use li t0, 1(?)
   beq a5, t0, Case1
   addi t0, t0, 1
   beq a5, t0, Case2
   addi t0, t0, 1
   beq a5, t0, Case3
   addi t0, t0, 1
   bne a5, t0, Default
   j ExitHard

Case1:
   addi t0, zero, -1 # make Z equal to -1
   sw  t0, 0(s11)
   j Exit # break out of case

Case2:
   addi t0, zero, -2 # make Z equal to -2
   sw  t0, 0(s11)
   j Exit # break out of case

Case3:
   addi t0, zero, -3 # make Z equal to -3
   sw  t0, 0(s11)
   j Exit # break out of case

Default:
   add t0, zero, zero # make Z equal to zero
   sw  t0, 0(s11)
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
