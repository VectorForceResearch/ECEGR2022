.data   # Data declaration section    

varA:   .word 3
varB:   .word 10
varC:   .word 20

.text   # Text declaration section

main:       # Start of code section

# Read variables from memory to registers
la s9, varA
la s10, varB
la s11, varC

addi ra, zero, 1010

# a Fib
lw s0, varA	
jal Fibonacci
mv a0, s1

# b Fib
lw s0, varB	
jal Fibonacci
mv a1, s1

# c Fib
lw s0, varC	
jal Fibonacci
mv a2, s1

j Exit

Fibonacci:
	beq s0, x0, Ret0
	addi t2, x0, 1
	beq, s0, t2, Ret1
	addi s0, s0, -2
Loop:
	beq s0, x0, RetF
	add s1, t0, t1
	addi t1, t0, 0
	addi t0, s1, 0
	addi s0, s0, -1
	jal x0, Loop
Ret0:
	addi a0, x0, 0
	jr ra#jal x0, Done
Ret1:
	addi a0, x0, 1
	jr ra#jal x0, Done
RetF: 
	add a0, x0, s1	
Done:
	jr ra

Exit:
   li  a7,10       #system call for an exit
   ecall	