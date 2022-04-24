# Working with variables in memory

    .data   # Data declaration section

a:   .word
b:   .word
c:   .word

.text   # Text declaration section

main:       # Start of code section

# Read variables from memory to registers
la  x10, a
la  x11, b
la  x12, c

addi  sp, sp, -16                    #make space for 3 words on the stack
sw    ra, 0(sp)
sw    s0, 4(sp)
sw    s1, 8(sp)
sw    s2, 12(sp)


addi a0, zero, 5                      #set main i = 5
jal AddItUp

addi a0, zero, 10		#set main j = 10
jal s1, AddItUp

add a0, s0, s1			#c=a+b

AddItUp:
        add t0, zero, zero            #set local i = 0
        add t1, zero, zero            #set local x = 0
        jal ra, ForLoop               #call ForLoop and get computed x

ForLoop:
        slt t3, t0, a0
        beq t3, zero, end
        addi t2, t0, 1			#i+1
        add  t1, t1, t2			#x = x + (i+1)
        addi t0, t0, 1                #i++
        j ForLoop

end:
	mv x10, t1
	jr ra


	lw s0 0(sp)
	lw s1 4(sp)
	lw s2 8(sp)
	lw ra 12(sp)
	addi sp sp 16
	jr ra
