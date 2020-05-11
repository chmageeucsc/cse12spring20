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
    	sle $t0, $s0, $0 
    	beq $t0, $0, initialize
    	nop
    	
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
	nop

	# end of beginLoop	
	
	initialize:
		# initialize $s2 as number of stars
    		subi $s2, $s0, 1
    		mul $s2, $s2, 2
    	
    		# initialize $s4 as useIn+1
    		addi $s4, $s0, 1
    	
    		# initialize $s5 as row+1
    		addi $s5, $s3, 1
    		
    		#if row = useIn + 1, move to outputText
    		beq $s3, $s4, outputText
    		nop
    		
    		# check each row
		#addi $s3, $s3, 1
		
		b patternLoop
		nop
		
	patternLoop: 
	
		# reset rows
		subi $s3, $s3, 1
	
    		numLoop:
    			
    			#if col = row+1, move to starLoop
    			beq $s6, $s5, starLoop
    			nop
    			
    			# print num 
 			la $a0, ($s1)
 			li $v0, 1
 			syscall
 			la $a0, 0x9
 			li $v0, 11
 			syscall
 			
 			# num = num + 1
 			addi $s1, $s1, 1
 			
 			# mirror = num - 1
 			subi $s7, $s1, 1
 			
 			# check next col
 			addi $s6, $s6, 1
 			
 			# if row = useIn, mirror numbers
 			beq $s3, $s0, numCont
 			nop
 			
 			b numLoop
 			nop
    			
    		starLoop:
    			
    			# while stars > 0
    			beq $s2, $0, numCont
    			nop
    			
    			# print stars
 			la $a0, 0x2A
 			li $v0, 11
 			syscall
 			la $a0, 0x9
 			li $v0, 11
 			syscall
 			
 			# stars = stars - 1
 			subi $s2, $s2, 1
 			
 			b starLoop
 			nop
 			
 		numCont:
 			# useIn = useIn - 1  &  reset stars
 			sub $t2, $s0, 1
 		
 			# set temp for useIn - 1
 			add $t2, $s0, $0
 			
 			subi $s2, $t2, 1
    			mul $s2, $s2, 2
    			
    			# if mirror = 0, print new line and start next row
    			beq $s7, $0, nextRow
    			nop
    			
    			# for loop of mirrored numbers
    			beq $s6, $s3, finNum
    			nop
    			
    			# print mirror
 			la $a0, ($s7)
 			li $v0, 1
 			syscall
 			la $a0, 0x9
 			li $v0, 11
 			syscall
 			
 			# mirror = mirror - 1
 			subi $s7, $s7, 1
 			
 			# check next column
 			addi $s6, $s6, 1
 			
 			# if column = row, 
 			beq $s6, $s3, zero
 			
 			#b numCont
 			#nop 
 			
 		nextRow:
 			la $a0, newLine
 			li $v0, 4
 			syscall	
 			
 			addi $s3, $s3, 1
 			b initialize
 			nop
 					
 		finNum:
 			
 			# print mirror and new line
 			la $a0, ($s7)
 			li $v0, 1
 			syscall 
 			la $a0, newLine
 			li $v0, 4
 			syscall		
 			
 			# if col at row = row+1, move to outputText
 			addi $s3, $s3, 1
 			addi $s5, $s5, 1
 			beq $s6, $s5, outputText
    			nop
    			
    		#addi $s3, $s3, 1
    		b patternLoop #loop back
    		nop
    	zero:
    		addi $s6, $0, 0
    		b finNum
    		
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
