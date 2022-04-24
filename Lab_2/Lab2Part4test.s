# Working with variables in memory

    .data   # Data declaration section

arrA:   .space   5
arrB:   .word   1,2,4,8,16

.text   # Text declaration section

main:       # Start of code section

# Read variables from memory to registers
la  x10, arrA        		# Load A
la  x11, arrB        		# Load B




add t2, zero, zero  		#load i initial into our temp

beq zero, zero, ForLoop		#Jim's BS

ForLoop:
   slti t3, t2, 5
   beq t3, zero, end0
   la t1, 0(x11) 			# Loads B[0] into register t1
   
   sub t0, t1, t3		# A[i]=B[i]-1
   slli t4, t2, 2		# Sets t4 to t0 * 4 (4 is number of bytes in an integer)
   add  t4, x10, t4
   sw t4, 0(x10) 
   slli t1, t1, 2		# Sets t5 to t1 * 4 (4 is number of bytes in an integer)
   add  t1, x11, t1
   sw t1, 0(x11)
   addi t2, t2, 1       #i++
   j ForLoop
end0: