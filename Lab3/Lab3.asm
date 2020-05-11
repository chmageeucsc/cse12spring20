##########################################################################
# Created by: Gee, Chantel
# chmagee
# 10 May 2020
#
# Assignment: Lab 3: ASCII-risks (Asterisks)
# CSE 12, Computer Systems and Assembly Language
# UC Santa Cruz, Spring 2020
#
# Description: This program prints takes the user's input and prints out
#		Floyd's Triangle forwards and backwards with "*" in
#		between them.
#
# Notes: This program is intended to be run from the MARS IDE.
#
##########################################################################
#
# PSEUDOCODE
# useIn = int(input("Enter the height of the pattern (must be greater than 0): "))
#
# while useIn <= 0 :
#    print("Invalid entry!")
#    useIn = int(input("Enter the height of the pattern (must be greater than 0): "))
# end while
#
# print()
#
# num = 1
# stars = (useIn-1) * 2
# for row in range (1, useIn+1) :
#    for col in range (1, row+1) :
#        print (num, end = "\t")
#        num = num + 1
#        mirror = num - 1
#    # end for
#    while stars > 0 :
#        print ("*", end = "\t")
#        stars = stars - 1
#    # end while
#    useIn = useIn-1
#    stars = (useIn-1) * 2
#    for col in range (1, row) :
#        print (mirror, end = "\t")
#        mirror = mirror - 1
#    # end for
#    for col in range (row, row+1) :
#        print (mirror)
#    print()
# # end for
#
##########################################################################

.text
main: 
	# row = 1
	addi $s1, $0, 1
	# col = 1
	addi $s2, $0, 1
	# count for loop iterations
	addi $s7, $0, 1
	
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
	
	initialize:
		# num = 1
		addi $s4, $0, 1
		# useIn = useIn + 1
		addi $s6, $s0, 1
		
		# print new line
	 	la $a0, newLine
	 	li $v0, 4
	 	syscall
	 		
		b forRow

	# for row in range (1, useIn + 1)
	forRow:
		# $s1 = row
		beq $s1, $s6, exit
		nop
		
		# for col in range (1, row + 1)
		forCol1:
			# $t1 = row + 1
			# s2 = col
			addi $t1, $s1, 1
			beq $s2, $t1, setStars
			nop
		
			# print (num, end = "\t")
			la $a0, ($s4)
	 		li $v0, 1
 			syscall
 			la $a0, 0x9
 			li $v0, 11
 			syscall
 		
 			# num = num + 1
 			addi $s4, $s4, 1
 		
 			# mirror = num - 1
 			# $s5 = mirror
 			subi $s5, $s4, 1
 			
 			# next column, restart loop
 			addi $s2, $s2, 1
 		
 			b forCol1
 			nop
	
		setStars:
			# $s3 = stars // stars = (useIn - 1) * 2
			subi $s3, $s0, 1
			mul $s3, $s3, 2
			
			b whileStars
			nop
	
		# while stars > 0	
		whileStars:
			
			beq $s3, 0, resetStars
			nop
		
			# print ("*", end = "\t")
			la $a0, 0x2A
	 		li $v0, 11
	 		syscall
	 		la $a0, 0x9
	 		li $v0, 11
	 		syscall
 		
	 		# stars = stars - 1
	 		subi $s3, $s3, 1
	 		
	 		#restart loop
	 		b whileStars
	 		nop
		
		resetStars:
			# useIn = useIn - 1
			subi $s0, $s0, 1
			# stars = (useIn - 1) * 2
			subi $s3, $s0, 1
			mul $s3, $s3, 2
			
			b resetCol
			nop
		
		resetCol:
			addi $s2, $0, 1
			b forCol2
			nop
		
		# for col in range (1, row)
		forCol2:
			beq $s2, $s1, forCol3
			nop
		
			# print (mirror, end = "\t")
			la $a0, ($s5)
 			li $v0, 1
 			syscall
 			la $a0, 0x9
 			li $v0, 11
 			syscall
 		
	 		# mirror = mirror - 1
 			subi $s5, $s5, 1
 			
 			# next column, restart loop
 			addi $s2, $s2, 1
 			b forCol2
 			nop
		
		# for col in range (row, row + 1)	
		forCol3:
			addi $t1, $s1, 1
			beq $s1, $t1, printLine
		
			# print (mirror)
			la $a0, ($s5)
 			li $v0, 1
 			syscall
 		
 			b printLine
		
		printLine:
			# print (), start next row
			la $a0, newLine
 			li $v0, 4
 			syscall
			
			# reset column for next row
			addi $s2, $0, 1
			
			# counter for numbers printed
			addi $s7, $s7, 1
			
			# next row
 			addi $s1, $s1, 1
 			b forRow
 			nop
 		
	exit:
	 	# Exit the program
		li $v0, 10
		syscall
 		
.data
newLine: .asciiz "\n"
prompt: .asciiz "Enter the height of the pattern (must be greater than 0):	"
error: .asciiz "Invalid entry!"
