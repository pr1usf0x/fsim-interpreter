label :start
li X9, 0
li X10, 24414
add X10, X10, X10
add X10, X10, X10
add X10, X10, X10
add X10, X10, X10
add X10, X10, X10
add X10, X10, X10
add X10, X10, X10
add X10, X10, X10
add X10, X10, X10
add X10, X10, X10
add X10, X10, X10
add X10, X10, X10
addi X10, X10, 256
li X11, 0
li X12, 1

label :loop
beq X10, X9, :done
add X13, X11, X12
add X11, X12, X9
add X12, X13, X9
addi X10, X10, -1
beq X9, X9, :loop

label :done
add X1, X11, X9
li X8, PRINT_UNSIGNED
syscall
li X8, EXIT
syscall
