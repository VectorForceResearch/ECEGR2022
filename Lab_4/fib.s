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
lw a3, varA	
jal Fibonacci
mv a0, a4

# b Fib
lw a3, varB	
jal Fibonacci
mv a1, a4

# c Fib
lw a3, varC	
jal Fibonacci
mv a2, a4 



sw a0, (s9)
sw a1, (s10)
sw a2, (s11)
j Exit

Fibonacci:
	addi sp, sp, -12                    #make space for 1 word on the stack
	sw   s0, 0(sp)
	sw   s1, 4(sp)
	sw   s2, 8(sp)
	
	slti t1, a3, 0
	blez t1, a3, setValueZero
	
	slti t1, a3, 1
	beq  t0, a3, setValueOne

	addi s0, a3, -1	
	addi s1, a3, -2
	jal Fibanocci

        add  s0, zero, zero            #set local i = 0
        add  s1, zero, zero            #set local x = 0

setValueZero:
	li   a4, 0
	jr   ra
	
setValueOne:
	li   a4, 1
	jal  ra	
	
	

ExitFxn:
	add  a4, zero, s1  
	lw   s0, 0(sp)
	lw   s1, 4(sp)
	addi sp, sp, 8                    #make space for 1 word on the stack
	jr ra

Exit:
   #.string "Program Completed Successfully!"
   li  a7,10       #system call for an exit
   ecall

