.data
prompt: .asciiz "Guess a number (1 - 1000): \n"
win:    .asciiz "You win!!\n"
higher: .asciiz "Your guess is too high! Try again: \n"
lower:  .asciiz "Your guess is too low! Try again: \n"
newline:.asciiz "\n"

.text
.globl main
main:
    li $t0, 0x1fa # 0x1fa --> t0=506, the secret number

LOOP: # beginning of loop
    # print out the prompt
    la $a0, prompt
    li $v0, 4
    syscall
    
    # read in an integer
    li $v0, 5
    syscall
    move $t1, $v0 # move the input number (user) to t1

    # Compare value of t1 and t0 using bgt, bge, blt, or ble
    beq $t0, $t1, WIN
    bgt $t1, $t0, HIGHER
    blt $t1, $t0, LOWER

HIGHER:
    # print out "higher"
    la $a0, higher
    li $v0, 4
    syscall
    j LOOP # jump back to loop, prompting another guess

LOWER:
    # print out "lower"
    la $a0, lower
    li $v0, 4
    syscall
    j LOOP # jump back to loop, prompting another guess

WIN:
    # print out "win"
    la $a0, win
    li $v0, 4
    syscall

    # Normally, here we would exit, but if you want to reset the game instead:
    # j loop # uncomment this line if you want the game to restart after winning

    # Game exit point
    li $v0, 10 # exit syscall number
    syscall # execute syscall to exit program