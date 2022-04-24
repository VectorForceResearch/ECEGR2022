# Working with variables in memory

    .data   # Data declaration section

vari:   .word   0
varZ:   .word   2

.text   # Text declaration section

main:       # Start of code section

# Read variables from memory to registers
lw  s0, vari        		# Load A
lw  s1, varZ        		# Load Z

#for(i=0; i<=20; i=i+2){Z++;}
add t0, zero, zero  		#load i initial into our temp
li t1, 2			#should be loading word Z here into temp

beq zero, zero, ForLoop

ForLoop:
   slti t3, t0, 20
   beq t3, zero, DoWhile
   addi t1, t1, 1		#z++
   addi t0, t0, 2               #i = i + 2
   j ForLoop

DoWhile:
   slti t3, t1, 100
   beq t3, zero, While
   addi t1, t1, 1               #z++
   j DoWhile


While:
   slt t3, zero, t0		#because t3 is a 1 until no longer needed, recycle
   beq t3, zero, Exit
   sub t1, t1, t3               #z--
   sub t0, t0, t3               #i--
   j While


Exit:
   li  a7,10       #system call for an exit
   ecall

# END OF PROGRAM
