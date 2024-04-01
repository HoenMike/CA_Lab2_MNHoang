.data
prompt: .asciiz "Guess a number (1 - 1000): \n"
win:    .asciiz "You win!!\n"
lose:   .asciiz "You lose!!\n"
higher:   .asciiz "Your guess is too high!\n"
lower:    .asciiz "Your guess is too low!\n"
newline:.asciiz "\n"

.text
.globl main
main:
    
    li $t0, 0x1fa # 0x1fa --> t0=506
    
    # print out the prompt
    la $a0, prompt
    li $v0, 4
    syscall
    
    # read in an integer
    li $v0, 5
    syscall
    move $t1, $v0 # move the input number (user) to t1; e.g 506
    
    # Compare value of t1 and t0 using bgt, bge, blt, or ble
    beq $t0, $t1, WIN
    bgt $t1, $t0, HIGHER
    ble $t1, $t0, LOWER
    
WIN:
    # print out "win"
    la $a0, win
    li $v0, 4
    syscall
    j EXIT
    
HIGHER:
    # print out "higher"
    la $a0, higher
    li $v0, 4
    syscall
    j EXIT
    
LOWER:
    # print out "lower"
    la $a0, lower
    li $v0, 4
    syscall

EXIT:
    jr $ra # return to caller (__start)
