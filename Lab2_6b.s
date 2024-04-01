.data
    binary_number:  .space 11    # Reserve space for the binary input string
    newline:        .asciiz "\n"  # Newline character for formatting

.text
main:
    # Prompt the user to input a binary number
    li $v0, 8             
    la $a0, binary_number  
    li $a1, 11              
    syscall

    # Initialize variables for conversion
    li $t0, 0             # Initialize the decimal result
    li $t1, 9             # Initialize the bit position (from right to left)

convert_loop:
    lb $t2, 0($a0)        # Load the next character from the binary string
    beq $t2, $zero, after_convert_loop
    sub $t2, $t2, '0'     # Convert ASCII digit to integer value

    sll $t3, $t2, $t1     # Shift the value to the appropriate position
    add $t0, $t0, $t3     # Accumulate the decimal result

    addi $a0, $a0, 1      # Move to the next character in the string
    addi $t1, $t1, -1     # Decrement the bit position
    j convert_loop         # Repeat the loop

    # Print a newline
    li $v0, 4               
    la $a0, newline         
    syscall

after_convert_loop:
    # Print the decimal result
    li $v0, 1               
    move $a0, $t0           
    syscall
    
    # Print another newline
    li $v0, 4               
    la $a0, newline         
    syscall

    # Exit the program
    li $v0, 10         
    syscall
