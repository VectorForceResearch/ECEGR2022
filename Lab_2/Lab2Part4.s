# Working with variables in memory

    .data   # Data declaration section


b:   .word   	1,2,4,8,16
a:   .space 	5 		#could use .word 0,0,0,0,0

.text   # Text declaration section

main:       # Start of code section

# Read variables from memory to registers
la  x10, a
la  x12, b
add x11, x0, x0

while: 	slti x13, x11, 5	# check if i < 5
	beq x13, x0, exit0	# branch if i >= 5

   	slli x14, x11, 2	# shift 4 * i
  	add  x14, x10, x14	# addr of x10 + 4*i

   	slli x15, x11, 2	# shift 4 * i
  	add  x15, x12, x15	# addr of x12 + 4*i

  	lw t1, (x15)		# load data from addr(x15) IF WE DON'T DO THIS, WE DEAL WITH ADDIES

  	addi x13, t1, -1	# temp a[i]=b[i]-1

   	sw x13, 0(x14) 		# store data(word) into addr(x13)
   	addi x11, x11, 1     	# i++
   	j while
exit0:

addi t6, zero, -1
sub x11, x11, t6


while2: slt x13, t6, x11	# check if 0 < i
	beq x13, zero, exit1	# branch if 0 >= i

   	slli x14, x11, 2	# shift 4 * i
  	add  x14, x10, x14	# addr of x10 + 4*i

   	slli x15, x11, 2	# shift 4 * i
  	add  x15, x12, x15	# addr of x12 + 4*i

  	lw t0, (x14)		# load data from addr(x15)
  	lw t1, (x15)
  	li t2, 2

  	add t3, t0, t1 	# temp a[i]=b[i]-1
  	mul t2, t3, t2
  	add x13, zero, t2
  	sw x13, 0(x14) 		# store data(word) into addr(x13)
   	addi x11, x11, -1    	# i--
   	j while2
exit1:

Exit:
   li  a7,10       #system call for an exit
   ecall

# END OF PROGRAM
