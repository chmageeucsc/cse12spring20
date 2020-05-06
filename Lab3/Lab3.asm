# Program File: Program2-2.asm
# Author: Charles Kann
# Program to read an integer number from a user, and
# print that number back to the console.
.text
main:
    # Prompt for the integer to enter
    # $a0: load address of prompt
    # $v0: load syscall value of 4 (prompt string)
    li $v0, 4
    la $a0, prompt
    syscall

    # Read the integer and save it in $s0
    # $v0: load syscall value of 5 (read int)
    # $s0: $v1 input moved into save register 0
    li $v0, 5
    syscall
    move $s0, $v0

    # loop to check the input
    beginLoop:
    
    	# Check if the integer is less than or equal to zero (if greater $t0 = 1, else $t0 = 0)
    	# $t0: print error if less than or equal to 0
    	# branch to patternLoop if input is greater than 0
    	sle $t1, $s0, $zero
    	beq $t1, $zero, patternLoop
    	
    	# error
    	la $a0, error
 	li $v0, 4
 	syscall
 	
 	# print new line
 	la $a0, newLine
 	li $v0, 4
 	syscall
 		
 	# print new line
 	la $a0, newLine
 	li $v0, 4
 	syscall
	
	# redo prompt
	la $a0, prompt
	li $v0, 4
 	syscall
 	
 	# save the new value
 	li $v0, 5
 	syscall
	move $s0, $v0

	# RETURN TO START OF LOOP
	b beginLoop

    # end of beginLoop	

    # initialize starting number for pattern
    	

    patternLoop: 
    	
    	
    # Output the text
    li $v0, 4
    la $a0, output
    syscall

    # Output the number
    li $v0, 1
    move $a0, $s0
    syscall
    
    #Print a new line after the output
    li $v0, 4
    la $a0, newLine
    syscall

    # Exit the program
    li $v0, 10
    syscall

.data
prompt: .asciiz "Enter the height of the pattern (must be greater than 0): "
output: .asciiz "\nYou typed the number "
newLine: .asciiz "\n"
error: .asciiz "Invalid entry!"
start: .word 1
    
