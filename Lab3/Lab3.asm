# Program File: Program2-2.asm
# Author: Charles Kann
# Program to read an integer number from a user, and
# print that number back to the console.
.text
main:
	# initialize $s1 as 1 (num)
    	lw $s1, start
    	
    	# initialize $s3 as 1 (row)
    	lw $s3, start
    	
    	# initialize $s6 as 1 (col)
    	lw $s6, start
	
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
    	beq $t3, $zero, patternLoop
    	
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
	
	# initialize $s2 as number of stars
    	subi $s2, $s0, 1
    	mul $s2, $s2, 2
    	
    	# initialize $s4 as useIn+1
    	addi $s4, $s0, 1
    	
    	# initialize $s5 as row+1
    	addi $s5, $s3, 1
    	
	# initialize starting number for pattern
	patternLoop: 
    		
    		#if row = useIn, move to outputText
    		beq $s3, $s4, outputText
    		
    		# set $s3 to $s7 (mirror = row)
    		add $s7, $s3, $0
    		
    		numLoop:
    			
    			#if col = row+1, move to starLoop
    			beq $s6, $s5, starLoop
    			
    			# print num 					#### PLEASE ADD TAB ###
 			la $a0, ($s1)
 			li $v0, 1
 			syscall
 			
 			# num = num + 1
 			addi $s1, $s1, 1
 			
 			# mirror = num - 1
 			subi $s7, $s1, 1
 			
 			#
 			
 			b numLoop
    			
    		starLoop:
    			
    			# while stars > 0
    			beq $s2, $0, numCont
    			
    			# print stars					#### PLEASE ADD TAB ###
 			la $a0, ($s2)
 			li $v0, 1
 			syscall
 			
 			# stars = stars - 1
 			subi $s2, $s2, 1
 			
 			b starLoop
 			
 		numCont:
 			
 			# useIn = useIn - 1  &  reset stars
 			sub $s0, $s0, 1
 			
 			subi $s2, $s0, 1
    			mul $s2, $s2, 2
    			
    			# for loop of mirrored numbers
    			beq $s6, $s3, finNum
    			
    			# print mirror					#### PLEASE ADD TAB ###
 			la $a0, ($s7)
 			li $v0, 1
 			syscall
 			
 			# mirror = mirror - 1
 			subi $s7, $s7, 1
 			
 			b numCont
 			
 		finNum:
 			
 			# if col = row+1, move to outputText
 			beq $s6, $s5, outputText
 			
 			# print mirror
 			la $a0, ($s7)
 			li $v0, 1
 			syscall
    	
    		addi $s3, $s3, 1
    		b patternLoop #loop back
    	
    	outputText:
    	
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
    
