# Working with variables in memory

    .data   # Data declaration section

vari:   .word   0
varZ:   .word   2

.text   # Text declaration section

main:       # Start of code section

# Read variables from memory to registers
lw  a0, vari        		# Load i
lw  a1, varZ        		# Load Z

la  s0, vari        		# Load i
la  s1, varZ        		# Load Z


#for(i=0; i<=20; i=i+2){Z++;}
li t1, 20
ForLoop:
   #slti t3, a0, 20
   #beq t3, zero, DoWhile
   #bge a0, t1, DoWhile
   blt t1, a0, DoWhile
   addi a1, a1, 1		#z++
   addi a0, a0, 2               #i = i + 2
   j ForLoop

DoWhile:
   slti t3, a1, 100
   beq t3, zero, While
   
   addi a1, a1, 1               #z++
   j DoWhile


While:
   slt t3, zero, a0		#because t3 is a 1 until no longer needed, recycle
   beq t3, zero, Exit
   sub a1, a1, t3               #z--
   sub a0, a0, t3               #i--
   j While



Exit:
   sw a0, vari,s0
   sw a1, varZ,s1
   li  a7,10       #system call for an exit
   ecall

# END OF PROGRAM
