# Working with variables in memory

    .data   # Data declaration section

varA:   .word 0
varB:   .word 0
varC:   .word 0

.text   # Text declaration section

main:       # Start of code section

# Read variables from memory to registers
la s9, varA
la s10, varB
la s11, varC

addi ra, zero, 1010

li x13, 5	# int i = 5
jal AddItUp
mv x10, x14#, (x10) # varA now equals AddItUp

li x13, 10	# int j = 10
jal AddItUp
mv x11, x14#, (x11) # varB now equals AddItUp

add x12, x10, x11			#c=a+b

sw x10, (s9)
sw x11, (s10)
sw x12, (s11)
j Exit

AddItUp:
	addi sp, sp, -8                    #make space for 1 word on the stack
	sw    s0, 0(sp)
	sw    s1, 4(sp)
        
        add s0, zero, zero            #set local i = 0
        add s1, zero, zero            #set local x = 0

ForLoop:
   	blt x13, s0, ExitFxn	# brnch less than n (where n is x13
        addi s1, s1, 1		# x = x + 1
        add  s1, s1, s0		# x = x + i
        addi s0, s0, 1          # i++
        j ForLoop

ExitFxn:
	add x14, zero, s1  
	lw    s0, 0(sp)
	lw    s1, 4(sp)
	addi sp, sp, 8                    #make space for 1 word on the stack
	jr ra

Exit:
   #.string "Program Completed Successfully!"
   li  a7,10       #system call for an exit
   ecall

