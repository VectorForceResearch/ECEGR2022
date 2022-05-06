# Working with variables in memory

    .data   # Data declaration section

varA:   .word   15
varB:   .word   10
varC:   .word   5
varD:   .word   2
varE:   .word   18
varF:   .word   -3
varZ:   .word   0

    .text   # Text declaration section

main:       # Start of code section

# Read variables from memory to registers (option 2)
    lw  s0, varA        # Load A
    lw  s1, varB        # Load B
    lw  s2, varC        # Load C
    lw  s3, varD        # Load D
    lw  s4, varE        # Load E
    lw  s5, varF        # Load F
    la  s11, varZ

    #z = (A-B);
    SUB t0, s0, s1

    #z = z + (C*D); could be an AND but there is a MUL
    MUL t1, s2, s3
    ADD t0, t0, t1

    #z = z + (E-F);
    SUB t1, s4, s5
    ADD t0, t0, t1

    #z = z - (A/C); could be an OR of some type but there is a DIV
    DIV t1, s0, s2
    SUB t0, t0, t1

    #store from registor to the memory variable
    sw  t0, 0(s11)

    li  a7,10       #system call for an exit
    ecall

# END OF PROGRAM
