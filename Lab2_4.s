.data
prompt: .asciiz "Input: "
output: .asciiz "Output: "
buffer: .space 100
newline: .asciiz "\n"

.text
.globl main
main:
 
	# Print out the prompt
	la $a0, prompt  
	li $v0, 4  
	syscall
 
	# Read a string
	li $v0, 8
	la $a0, buffer
	li $a1, 100
	syscall

	# Print a newline
	la $a0, newline
	li $v0, 4  
	syscall
	
	# Capitalize the first letter of each word
	la $t0, buffer
	li $t1, 1  # Flag to indicate the start of a word
	
capitalize_loop:
	lb $t2, ($t0)  # Load the current character
	beqz $t2, print_result  # If null terminator, print the result
	
	# Check if the current character is a space or newline
	beq $t2, 32, set_word_start
	beq $t2, 10, set_word_start
	
	# Check if the current character is lowercase and we are at the start of a word
	li $t3, 97
	li $t4, 122
	blt $t2, $t3, not_lowercase
	bgt $t2, $t4, not_lowercase
	beqz $t1, not_lowercase  # If not at the start of a word, do not capitalize
	
	# Capitalize the first letter of the word
	sub $t2, $t2, 32
	li $t1, 0  # Reset the flag as we have capitalized the first letter of the word
	
not_lowercase:
	sb $t2, ($t0)  # Store the modified character
	addi $t0, $t0, 1  # Move to the next character
	j capitalize_loop
	
set_word_start:
	li $t1, 1  # Set the flag to indicate the start of a word
	addi $t0, $t0, 1  # Move to the next character
	j capitalize_loop
	
print_result:
	# Print out the result
	la $a0, output
	li $v0, 4  
	syscall
 
	la $a0, buffer
	li $v0, 4  
	syscall
 
	la $a0, newline
	li $v0, 4  
	syscall
 
	jr $ra  # Return to caller (__start)