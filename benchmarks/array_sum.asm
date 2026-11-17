label :start
li X9, 0
li X10, 16384
add X10, X10, X10
li X12, 25000
add X12, X12, X12
add X12, X12, X12
li X11, 1
li X14, 1000
li X1, 0

label :fill
st X11, [X10, 0]
addi X10, X10, 4
addi X11, X11, 1
addi X12, X12, -1
beq X12, X9, :sum_start
beq X9, X9, :fill

label :sum_start
li X10, 16384
add X10, X10, X10
li X12, 25000
add X12, X12, X12
add X12, X12, X12

label :sum_loop
ld X11, [X10, 0]
add X1, X1, X11
addi X10, X10, 4
addi X12, X12, -1
beq X12, X9, :next_pass
beq X9, X9, :sum_loop

label :next_pass
addi X14, X14, -1
beq X14, X9, :done
beq X9, X9, :sum_start

label :done
li X8, PRINT_UNSIGNED
syscall
li X8, EXIT
syscall
