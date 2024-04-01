.data
promptN: .asciiz "Enter the value for N: "
promptM: .asciiz "Enter the value for M: "
promptX: .asciiz "Enter the value for X: "
space: .asciiz " "

.text
.globl main
main:
    # Read N
    li $v0, 4
    la $a0, promptN
    syscall
    li $v0, 5
    syscall
    move $s0, $v0  # N

    # Read M
    li $v0, 4
    la $a0, promptM
    syscall
    li $v0, 5
    syscall
    move $s1, $v0  # M

    # Read X
    li $v0, 4
    la $a0, promptX
    syscall
    li $v0, 5
    syscall
    move $s2, $v0  # X

    # Initialize counter
    li $t0, 0  # counter

    # Start loop
loop:
    # Calculate N * M^counter
    move $t1, $s1  # M
    li $t2, 1  # M^counter
    li $t3, 0  # loop variable for calculating M^counter
    power_loop:
        bge $t3, $t0, end_power_loop
        mul $t2, $t2, $t1
        addi $t3, $t3, 1
        j power_loop
    end_power_loop:
    mul $t1, $s0, $t2  # N * M^counter

    # Print N * M^counter
    move $a0, $t1
    li $v0, 1
    syscall

    # Print a space
    li $v0, 4
    la $a0, space
    syscall

    # Increment counter
    addi $t0, $t0, 1

    # Check if counter < X
    blt $t0, $s2, loop

    # Exit
    li $v0, 10
    syscall