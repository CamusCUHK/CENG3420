 .globl _start
 
 .data
 empty1: .asciz "\n"
var1:  .word 20
var2: .word 19
 

 .text
_start:

#  print var1
li a7, 1# system call code for PrintString
la t0,  var1	# save address of var1 and var2 as t0 and t1
lw a0, 0(t0)
ecall

#  print newline
li a7, 4 # system call code for PrintString
la a0, empty1
ecall

#  print var2
li a7, 1# system call code for PrintString
la t1,  var2	# save address of var1 and var2 as t0 and t1
lw a0, 0(t1)
ecall

#  print newline
li a7, 4
la a0, empty1
ecall

#modify var1,2 by load word and save word
lw a0, 0(t0)
addi a0, a0, 1	# var1 = var1 + 1
sw a0, 0(t0)

lw a0, 0(t1)
slli a0, a0, 2	# var2= var2 * 2
sw a0, 0(t1)

#  print var1
li a7, 1
lw a0, 0(t0)
ecall

#  print newline
li a7, 4
la a0, empty1
ecall

#  print var2
li a7, 1
lw a0, 0(t1)
ecall

#  print newline
li a7, 4
la a0, empty1
ecall

# swap var1 and var2 by load word and save word
lw t2, 0(t0)
lw t3, 0(t1)
sw t2, 0(t1)
sw t3, 0(t0)

#  print var1
li a7, 1
lw a0, 0(t0)
ecall

#  print newline
li a7, 4
la a0, empty1
ecall

#  print var2
li a7, 1
lw a0, 0(t1)
ecall
