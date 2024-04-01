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

			# Initialize counter and current value
			li $t0, 0  # counter
			move $t1, $s0  # current value = N

			# Start loop
		loop:
			# Print current value
			move $a0, $t1
			li $v0, 1
			syscall

			# Print a space
			li $v0, 4
			la $a0, space
			syscall

			# Calculate next value
			mul $t1, $t1, $s1  # current value *= M

			# Increment counter
			addi $t0, $t0, 1

			# Check if counter < X
			blt $t0, $s2, loop

			# Exit
			li $v0, 10
			syscall