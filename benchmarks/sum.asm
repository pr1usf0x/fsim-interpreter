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
li X1, 0

label :loop
beq X10, X9, :done
add X1, X1, X10
addi X10, X10, -1
beq X9, X9, :loop

label :done
li X8, PRINT_UNSIGNED
syscall
li X8, EXIT
syscall
