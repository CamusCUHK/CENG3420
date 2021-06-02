 .globl _start
 
 .data
 a: .word -1 22 8 35 5 4 11 2 1 78
 
 #  s1 = array length s2 = i s3 = pivot s4 = left s5 = right 
 .text
  _start:
 la a0, a
 addi s1, zero, 9	# number of integer in array
 addi s2, zero, 0	# s2= 0 for i use foploop
 
 addi s3, zero, 0	# s3= 0 for pivot
 addi s4, zero, 0	# s4= 0 for left
 add s5, zero, s1	# s5= 0 for Right (begining default as Rightest 1 = s1)
 
 #  quicksort _1-> partition -> quicksort _1 -> quicksort _1_L ->  partition  -> quicksort _1_L -> quicksort _1_L_L ->......
quickSort:
addi sp, sp, -16
sw ra, 12(sp) 
sw s5, 4(sp) 
sw s4, 0(sp) 
ble s5,s4,exitquickSort
add s2, zero, s4
jal  partition
# addi s7, zero, 1000 # check point 1 #ok
sw s3, 8(sp) 		# save pivot point after partition

addi s5, s3, -1		# Right = Pivot -1
add s3, zero, s4	# reset pivot point for partition
jal quickSort		# quickSort( Left, Pivot -1)


lw s5, 4(sp) 		# load back Righr and pivot Value from stack
lw s3, 8(sp) 
addi s4, s3, 1		# Left = pivot + 1
add s3, zero, s4 	# reset pivot point for partition
jal quickSort		# quickSort(pivot + 1, Right)
jal Done	

#parttitopn 
partition:
addi sp, sp, -4
sw ra, 0(sp) 		# save return address to quicksort function
partitionLoop:
slli t1, s2, 2		# sub current i in to 4*address
add t1, t1, a0		# t1 = array[0+i] address
lw t0, 0(t1)		# t0 = array[0+i]	
slli t3, s5, 2
add t3, t3, a0
lw t5, 0(t3) 		# t5 = pivot element
slt t2, t0, t5		# t2 = 1 if t0 < t5(pivot element) 
bne t2, zero, smallSwap	# t2 != 0 -> mean t0 < pivot value then jump to smallSwap

SwapExit:
addi s2, s2, 1	# i = i+1
beq s2, s5, exit
jal partitionLoop
exit:
slli t1, s2, 2	# s2 is current no: i
add t1, a0, t1
slli t3, s3, 2	# s2 is partictian no
add t3, a0, t3
lw t0, 0(t1)
lw t2, 0(t3)
sw t2, 0(t1)
sw t0, 0(t3) 
lw ra, 0(sp) 
addi sp, sp, 4	
jr ra

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

#parttitopn Done

exitquickSort:
lw ra, 12(sp) 
addi sp, sp, 16
jr ra

Done:
lw ra, 12(sp)
addi sp, sp, 16
beq ra, zero, Exitall		# prevent ra == 0 when start of quick sort
jr ra

Exitall:
