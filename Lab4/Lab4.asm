##########################################################################
# Created by: Gee, Chantel
# chmagee
# 16 May 2020
#
# Assignment: Lab 4: Sorting Integers
# CSE 12, Computer Systems and Assembly Language
# UC Santa Cruz, Spring 2020
#
# Description: This program takes program arguments in hex, converts
#		them into decimals, and sorts them.
#
# Notes: This program is intended to be run from the MARS IDE.
#
##########################################################################
#
# PSEUDOCODE
# 
# print "program arguments"
# pa loop
# if $a1 = 0, move on to integer values
# else, print argument
# store argument
# check next argument - another pa loop
# 
# "integer values"
# (ascii to hex)
# check if first byte (after 0x) is letter or number
# letter:
# load byte
# convert to hex value
# store and shift to make space for next value
# next byte - loop back to check
# number:
# load byte
# convert to hex value
# store and shift to make space for next value
# next byte - loop back to check
# 
# repeat checks with next ascii/hex
# 
# (hex to int)
# load byte (after 0x)
# mult by 256 and store
# next byte (if not null)
# mult by 16 and store
# next byte (if not null)
# add byte and previous products and store
# 
# repeat with next hex/int
# 
# "sorted values"
# sorting:
# compare first stored value (a) to second (b)
# if a > b, swap values
# parse through all values until sorted
# 
# print out sorted values
# 
##########################################################################

main:
	program_arguments:
		# prompt for "Program arguments"
		li $v0, 4
		la $a0, pa
		syscall
		
		# new line
		li $v0, 4
		la $a0, newLine
		syscall
		
		# print program arguements 1
		beq $a1, $0, ascii_hex_1
		
		li $v0, 4
		lw $a0, ($a1)
		syscall
		
		lw $s0, ($a1)
		# shift to remove 0x
		addi $s0, $s0, 2
		move $t0, $s0
						
		# space between arguments
		li $v0, 4
		la $a0, space
		syscall
		
		# print program arguements 2
		addi $a1, $a1, 4
		beq $a1, 0x7fffeffc, ascii_hex_1
		subi $a1, $a1, 4
		
		li $v0, 4
		lw $a0, 4($a1)
		syscall
		
		lw $s1, 4($a1)
		# shift to remove 0x
		addi $s1, $s1, 2
		move $t1, $s1
						
		# space between arguments
		li $v0, 4
		la $a0, space
		syscall
		
		# print program arguements 3
		addi $a1, $a1, 8
		beq $a1, 0x7fffeffc, ascii_hex_1
		subi $a1, $a1, 8
		
		li $v0, 4
		lw $a0, 8($a1)
		syscall
		
		lw $s2, 8($a1)
		# shift to remove 0x
		addi $s2, $s2, 2
		move $t2, $s2
						
		# space between arguments
		li $v0, 4
		la $a0, space
		syscall	
		
		# print program arguements 4
		addi $a1, $a1, 12
		beq $a1, 0x7fffeffc, ascii_hex_1
		subi $a1, $a1, 12
		
		li $v0, 4
		lw $a0, 12($a1)
		syscall
		
		lw $s3, 12($a1)
		# shift to remove 0x
		addi $s3, $s3, 2
		move $t3, $s3
						
		# space between arguments
		li $v0, 4
		la $a0, space
		syscall	
		
		# print program arguements 5
		addi $a1, $a1, 16
		beq $a1, 0x7fffeffc, ascii_hex_1
		subi $a1, $a1, 16
		
		li $v0, 4
		lw $a0, 16($a1)
		syscall
		
		lw $s4, 16($a1)
		# shift to remove 0x
		addi $s4, $s4, 2
		move $t4, $s4
						
		# space between arguments
		li $v0, 4
		la $a0, space
		syscall
		
		# print program arguements 6
		addi $a1, $a1, 20
		beq $a1, 0x7fffeffc, ascii_hex_1
		subi $a1, $a1, 20
		
		li $v0, 4
		lw $a0, 20($a1)
		syscall
		
		lw $s5, 20($a1)
		# shift to remove 0x
		addi $s5, $s5, 2
		move $t5, $s5
						
		# space between arguments
		li $v0, 4
		la $a0, space
		syscall
		
		# print program arguements 7
		addi $a1, $a1, 24
		beq $a1, 0x7fffeffc, ascii_hex_1
		subi $a1, $a1, 24
		
		li $v0, 4
		lw $a0, 24($a1)
		syscall
		
		lw $s6, 24($a1)
		# shift to remove 0x
		addi $s6, $s6, 2
		move $t6, $s6
						
		# space between arguments
		li $v0, 4
		la $a0, space
		syscall	
		
		# print program arguements 8
		addi $a1, $a1, 28
		beq $a1, 0x7fffeffc, ascii_hex_1
		subi $a1, $a1, 28
		
		li $v0, 4
		lw $a0, 28($a1)
		syscall
		
		lw $s7, 28($a1)
		# shift to remove 0x
		addi $s7, $s7, 2
		move $t7, $s7
						
		# space between arguments
		li $v0, 4
		la $a0, space
		syscall	
		
	ascii_hex_1:
		# load first byte from program arguments
		lb $t8, 0($t0)
		# if null, move on
		beq $t8, 0, store1
		# if greater than or equal to "A", go to letter
		bge $t8, 0x041, letter1
		nop
		# else go to number
		b number1
		nop
		
		letter1:
			# shift left to store bytes
			sll $t9, $t9, 4
			# subtract to get hex value
			sub $t8, $t8, 55
			# store value
			add $t9, $t8, $t9
			add $t0, $t0, 1
			
			b ascii_hex_1
		
		number1:
			# shift left to store bytes
			sll $t9, $t9, 4
			# subtract to get hex value
			sub $t8, $t8, 48
			# store value
			add $t9, $t8, $t9
			add $t0, $t0, 1
			
			b ascii_hex_1
		
	store1: 
		# s0 is in hex
		add $s0, $0, $t9
		
		# store in stack
		subi $sp, $sp, 4
		sw $s0, 0($sp)
		
		# reset temporary values
		add $t9, $0, $0
		add $t8, $0, $0
		
	ascii_hex_2:
		# if no program arg, move on 
		beq $t1, $0, exit
		# load first byte from program arguments
		lb $t8, 0($t1)
		# if null, move on
		beq $t8, 0, store2
		# if greater than or equal to "A", go to letter
		bge $t8, 0x041, letter2
		nop
		# else go to number
		b number2
		nop
		
		letter2:
			# shift left to store bytes
			sll $t9, $t9, 4
			# subtract to get hex value
			sub $t8, $t8, 55
			# store value
			add $t9, $t8, $t9
			add $t1, $t1, 1
			
			b ascii_hex_2
		
		number2:
			# shift left to store bytes
			sll $t9, $t9, 4
			# subtract to get hex value
			sub $t8, $t8, 48
			# store value
			add $t9, $t8, $t9
			add $t1, $t1, 1
			
			b ascii_hex_2
			
	store2: 
		# s1 is in hex
		add $s1, $0, $t9
		
		# store in stack
		subi $sp, $sp, 4
		sw $s1, 0($sp)
		
		# reset temporary values
		add $t9, $0, $0
		add $t8, $0, $0
			
	ascii_hex_3:
		# if no program arg, move on 
		beq $t2, $0, exit
		# load first byte from program arguments
		lb $t8, 0($t2)
		# if null, move on
		beq $t8, 0, store3
		# if greater than or equal to "A", go to letter
		bge $t8, 0x041, letter3
		nop
		# else go to number
		b number3
		nop
		
		letter3:
			# shift left to store bytes
			sll $t9, $t9, 4
			# subtract to get hex value
			sub $t8, $t8, 55
			# store value
			add $t9, $t8, $t9
			add $t2, $t2, 1
			
			b ascii_hex_3
		
		number3:
			# shift left to store bytes
			sll $t9, $t9, 4
			# subtract to get hex value
			sub $t8, $t8, 48
			# store value
			add $t9, $t8, $t9
			add $t2, $t2, 1
			
			b ascii_hex_3
			
	store3: 
		# s2 is in hex
		add $s2, $0, $t9
		
		# store in stack
		subi $sp, $sp, 4
		sw $s2, 0($sp)
		
		# reset temporary values
		add $t9, $0, $0
		add $t8, $0, $0
	
	ascii_hex_4:
		# if no program arg, move on 
		beq $t3, $0, exit
		# load first byte from program arguments
		lb $t8, 0($t3)
		# if null, move on
		beq $t8, 0, store4
		# if greater than or equal to "A", go to letter
		bge $t8, 0x041, letter4
		nop
		# else go to number
		b number4
		nop
		
		letter4:
			# shift left to store bytes
			sll $t9, $t9, 4
			# subtract to get hex value
			sub $t8, $t8, 55
			# store value
			add $t9, $t8, $t9
			add $t3, $t3, 1
			
			b ascii_hex_4
		
		number4:
			# shift left to store bytes
			sll $t9, $t9, 4
			# subtract to get hex value
			sub $t8, $t8, 48
			# store value
			add $t9, $t8, $t9
			add $t3, $t3, 1
			
			b ascii_hex_4
			
	store4: 
		# s3 is in hex
		add $s3, $0, $t9
		
		# store in stack
		subi $sp, $sp, 4
		sw $s3, 0($sp)
		
		# reset temporary values
		add $t9, $0, $0
		add $t8, $0, $0
	
	ascii_hex_5:
		# if no program arg, move on 
		beq $t4, $0, exit
		# load first byte from program arguments
		lb $t8, 0($t4)
		# if null, move on
		beq $t8, 0, store5
		# if greater than or equal to "A", go to letter
		bge $t8, 0x041, letter5
		nop
		# else go to number
		b number5
		nop
		
		letter5:
			# shift left to store bytes
			sll $t9, $t9, 4
			# subtract to get hex value
			sub $t8, $t8, 55
			# store value
			add $t9, $t8, $t9
			add $t4, $t4, 1
			
			b ascii_hex_5
		
		number5:
			# shift left to store bytes
			sll $t9, $t9, 4
			# subtract to get hex value
			sub $t8, $t8, 48
			# store value
			add $t9, $t8, $t9
			add $t4, $t4, 1
			
			b ascii_hex_5
			
	store5: 
		# s4 is in hex
		add $s4, $0, $t9
		
		# store in stack
		subi $sp, $sp, 4
		sw $s4, 0($sp)
		
		# reset temporary values
		add $t9, $0, $0
		add $t8, $0, $0
		
	ascii_hex_6:
		# if no program arg, move on 
		beq $t5, $0, exit
		# load first byte from program arguments
		lb $t8, 0($t5)
		# if null, move on
		beq $t8, 0, store6
		# if greater than or equal to "A", go to letter
		bge $t8, 0x041, letter6
		nop
		# else go to number
		b number6
		nop
		
		letter6:
			# shift left to store bytes
			sll $t9, $t9, 4
			# subtract to get hex value
			sub $t8, $t8, 55
			# store value
			add $t9, $t8, $t9
			add $t5, $t5, 1
			
			b ascii_hex_6
		
		number6:
			# shift left to store bytes
			sll $t9, $t9, 4
			# subtract to get hex value
			sub $t8, $t8, 48
			# store value
			add $t9, $t8, $t9
			add $t5, $t5, 1
			
			b ascii_hex_6
			
	store6: 
		# s5 is in hex
		add $s5, $0, $t9
		
		# store in stack
		subi $sp, $sp, 4
		sw $s5, 0($sp)
		
		# reset temporary values
		add $t9, $0, $0
		add $t8, $0, $0
		
	ascii_hex_7:
		# if no program arg, move on 
		beq $t6, $0, exit
		# load first byte from program arguments
		lb $t8, 0($t6)
		# if null, move on
		beq $t8, 0, store7
		# if greater than or equal to "A", go to letter
		bge $t8, 0x041, letter7
		nop
		# else go to number
		b number7
		nop
		
		letter7:
			# shift left to store bytes
			sll $t9, $t9, 4
			# subtract to get hex value
			sub $t8, $t8, 55
			# store value
			add $t9, $t8, $t9
			add $t6, $t6, 1
			
			b ascii_hex_7
		
		number7:
			# shift left to store bytes
			sll $t9, $t9, 4
			# subtract to get hex value
			sub $t8, $t8, 48
			# store value
			add $t9, $t8, $t9
			add $t6, $t6, 1
			
			b ascii_hex_7
			
	store7: 
		# s6 is in hex
		add $s6, $0, $t9
		
		# store in stack
		subi $sp, $sp, 4
		sw $s6, 0($sp)
		
		# reset temporary values
		add $t9, $0, $0
		add $t8, $0, $0
		
	ascii_hex_8:
		# if no program arg, move on 
		beq $t7, $0, exit
		# load first byte from program arguments
		lb $t8, 0($t7)
		# if null, move on
		beq $t8, 0, store8
		# if greater than or equal to "A", go to letter
		bge $t8, 0x041, letter8
		nop
		# else go to number
		b number8
		nop
		
		letter8:
			# shift left to store bytes
			sll $t9, $t9, 4
			# subtract to get hex value
			sub $t8, $t8, 55
			# store value
			add $t9, $t8, $t9
			add $t7, $t7, 1
			
			b ascii_hex_8
		
		number8:
			# shift left to store bytes
			sll $t9, $t9, 4
			# subtract to get hex value
			sub $t8, $t8, 48
			# store value
			add $t9, $t8, $t9
			add $t7, $t7, 1
			
			b ascii_hex_8
			
	store8: 
		# s7 is in hex
		add $s7, $0, $t9
		
		# store in stack
		subi $sp, $sp, 4
		sw $s7, 0($sp)
		
		# reset temporary values
		add $t9, $0, $0
		add $t8, $0, $0
		
	integer_values:
		# new line
		li $v0, 4
		la $a0, newLine
		syscall
		
		# new line
		li $v0, 4
		la $a0, newLine
		syscall
	
		# print "Integer values"
		li $v0, 4
		la $a0, iv
		syscall
	
		# new line
		li $v0, 4
		la $a0, newLine
		syscall
		
		# print int 1 and space
		li $v0, 1
		move $a0, $s0
		syscall
		li $v0, 4
		la $a0, space
		syscall
		# print int 2 and space
		li $v0, 1
		move $a0, $s1
		syscall
		li $v0, 4
		la $a0, space
		syscall
		# print int 3 and space
		li $v0, 1
		move $a0, $s2
		syscall
		li $v0, 4
		la $a0, space
		syscall
		# print int 4 and space
		li $v0, 1
		move $a0, $s3
		syscall
		li $v0, 4
		la $a0, space
		syscall
		# print int 5 and space
		li $v0, 1
		move $a0, $s4
		syscall
		li $v0, 4
		la $a0, space
		syscall
		# print int 6 and space
		li $v0, 1
		move $a0, $s5
		syscall
		li $v0, 4
		la $a0, space
		syscall
		# print int 7 and space
		li $v0, 1
		move $a0, $s6
		syscall
		li $v0, 4
		la $a0, space
		syscall
		# print int 8 and space
		li $v0, 1
		move $a0, $s7
		syscall
		li $v0, 4
		la $a0, space
		syscall
		
		# new line
		li $v0, 4
		la $a0, newLine
		syscall
		
		# new line
		li $v0, 4
		la $a0, newLine
		syscall
	
	sorted_values:
		# print "Sorted values"
		li $v0, 4
		la $a0, sv
		syscall
		
		# new line
		li $v0, 4
		la $a0, newLine
		syscall
	
exit:
	# exit the program
	li $v0, 10
	syscall
	
.data
pa: .asciiz "Program arguments: "
iv: .asciiz "Integer values: "
sv: .asciiz "Sorted values: "
newLine: .asciiz "\n"
space: .asciiz " "
