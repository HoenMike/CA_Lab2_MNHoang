.data
prompt_a: .asciiz "Enter value for a: "
prompt_b: .asciiz "Enter value for b: "
prompt_c: .asciiz "Enter value for c: "
prompt_d: .asciiz "Enter value for d: "
result_F: .asciiz "Result F: "
result_G: .asciiz "Result G: "
newline:  .asciiz "\n"

.text
.globl main
main:
    # Read input values for a, b, c, and d
    li $v0, 5
    syscall
    move $s0, $v0  # a

    li $v0, 5
    syscall
    move $s1, $v0  # b

    li $v0, 5
    syscall
    move $s2, $v0  # c

    li $v0, 5
    syscall
    move $s3, $v0  # d

    # Calculate F
    add $t4, $s0, $s1  # a + b
    sub $t5, $s2, $s3  # c - d
    mul $t4, $t4, $t5  # (a + b) * (c - d)
    mul $t5, $s0, $s0  # a^2
    div $t4, $t5       # F = ((a + b) * (c - d)) / a^2

    # Calculate G
    addi $t0, $s0, 1   # a + 1
    addi $t1, $s1, 2   # b + 2
    sub $t2, $s2, $s0  # c - a
    mul $t6, $t0, $t1  # (a + 1) * (b + 2)
    div $t6, $t2       # G = ((a + 1) * (b + 2)) / (c - a)

    # Print results
    li $v0, 4
    la $a0, result_F
    syscall
    move $a0, $t4
    li $v0, 1
    syscall

    li $v0, 4
    la $a0, newline
    syscall

    li $v0, 4
    la $a0, result_G
    syscall
    move $a0, $t6
    li $v0, 1
    syscall

    # Exit program
    li $v0, 10
    syscall
