 .globl _start
 
 
.data
a: .word -1 22 8 35 5 4 11 2 1 78
  
  .text
  _start:
 la a0, a		# base array address save in a0
 addi s1, zero, 9	# number of integer in array
 addi s2, zero, 0	# s2= 0 for i use
 addi s3, zero, 0	# s3= 0 for position if 3rd element use
 lw s4,	8(a0)		# s4= 8 for compare
 lw t0, 36(a0)
 lw t2, 8(a0)
 sw t2, 36(a0)
 sw t0, 8(a0) 
 jal loop
 
 #  LOOP (i = 0)-> SMALLSWAP -> SWAPEXIT -> LOOP (i = 1)-> .... -> LOOP (i = arrayLength)-> EXIT
loop:
slli t1, s2, 2		# sub current i in to 4*address
add t1, t1, a0		# t1 = array[0+i] address
lw t0, 0(t1)		# t0 = array[0+i]
slt t2, t0, s4		# t2 = 1 if t0 < s4(pivot element) 
bne t2, zero, smallSwap	# t2 != 0 -> mean t0 < s4 then jump to smallSwap

SwapExit:
addi s2, s2, 1	# i = i+1
beq s2, s1, exit
jal loop

smallSwap:
slli t1, s2, 2	# s2 is current no: i
add t1, a0, t1	# t1 = t1 = array[0+i] address
slli t3, s3, 2	# s3 is partictian no
add t3, a0, t3  # t3 = array[0+P]
lw t0, 0(t1)
lw t2, 0(t3)
sw t2, 0(t1)
sw t0, 0(t3) 
addi s3, s3, 1
jal SwapExit

exit:
slli t1, s2, 2	# s2 is current no: i
add t1, a0, t1
slli t3, s3, 2	# s2 is partictian no
add t3, a0, t3
lw t0, 0(t1)
lw t2, 0(t3)
sw t2, 0(t1)
sw t0, 0(t3) 


