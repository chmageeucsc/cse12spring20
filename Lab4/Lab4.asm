##########################################################################
# Created by: Gee, Chantel
# chmagee
# 15 May 2020
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
		beq $a1, $0, integer_values
		
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
		beq $a1, 0x7fffeffc, integer_values
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
		beq $a1, 0x7fffeffc, integer_values
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
		beq $a1, 0x7fffeffc, integer_values
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
		beq $a1, 0x7fffeffc, integer_values
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
		beq $a1, 0x7fffeffc, integer_values
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
		beq $a1, 0x7fffeffc, integer_values
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
		beq $a1, 0x7fffeffc, integer_values
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
