.data   # Data declaration section    
temp_F:     .word   212
temp_C:     .word   0
offset:     .word   32
rise:       .word   5
run:        .word   9
maybe:      .word   27315
this:       .word   100

.text   # Text declaration section


main:

lw a0, temp_F
lw a1, offset
lw a2, rise
lw a3, run
lw a4, maybe
lw a5, this
fcvt.s.w ft0, a0 #temp_F
fcvt.s.w ft1, a1 #offset
fcvt.s.w ft2, a2 #rise
fcvt.s.w ft3, a3 #run
fcvt.s.w ft4, a4 #15
fcvt.s.w ft5, a5 #100

fsub.s fa4, ft0, ft1  #subtract 32    
fmul.s fa5, fa4, ft2  #multiple by 5
fdiv.s fa6, fa5, ft3  #divide by 9  
#fdiv.s fa7, ft4, ft5
flw fa7, 273.15, t0
fadd.s fa4, fa6, fa7
la     a5, temp_C
fsw    fa7, (a5)

exit:

ori a7, zero, 10    # define program exit system call
ecall           # exit program
