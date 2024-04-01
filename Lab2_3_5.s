.data
prompt: .asciiz "Guess a number (1 - 1000 or 0 to quit): \n"
win:    .asciiz "You win!!\n"
higher: .asciiz "Your guess is too high! Try again or press 0 to quit: \n"
lower:  .asciiz "Your guess is too low! Try again or press 0 to quit: \n"
goodbye:.asciiz "Thanks for playing!\n"
newline:.asciiz "\n"

.text
.globl main
main:
    li $t0, 0x1fa # 0x1fa --> t0=506, the secret number

loop: # beginning of loop
    # print out the prompt
    la $a0, prompt
    li $v0, 4
    syscall
    
    # read in an integer
    li $v0, 5
    syscall
    move $t1, $v0 # move the input number (user) to t1
    
    # Check if the user wants to quit the game
    li $t2, 0 # Set t2 to 0, the quit flag
    beq $t1, $t2, QUIT # If the user input is 0, jump to the QUIT label
    
    # Compare value of t1 and t0 using bgt, bge, blt, or ble
    beq $t0, $t1, WIN
    bgt $t1, $t0, HIGHER
    blt $t1, $t0, LOWER

HIGHER:
    # print out "higher"
    la $a0, higher
    li $v0, 4
    syscall
    j loop # jump back to loop, prompting another guess

LOWER:
    # print out "lower"
    la $a0, lower
    li $v0, 4
    syscall
    j loop # jump back to loop, prompting another guess

WIN:
    # print out "win"
    la $a0, win
    li $v0, 4
    syscall
    j QUIT # jump to QUIT to end the game

QUIT:
    # print goodbye message and quit
    la $a0, goodbye
    li $v0, 4
    syscall
    li $v0, 10 # exit syscall number
    syscall # execute syscall to exit program