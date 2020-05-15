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
