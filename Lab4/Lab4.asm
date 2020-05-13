main:
	program_arguments:
		# prompt for Program arguments
		li $v0, 4
		la $a0, pa
		syscall
		
		# new line
		li $v0, 4
		la $a0, newLine
		syscall
		
		# print program arguements
		li $v0, 4
		lw $a0, ($a1)
		syscall
			
		print_loop:
			beq $a1, 0x00000000, integer_values
			
			# space between arguments
			li $v0, 4
			la $a0, space
			syscall
			
			# next address/ program argument
			addi $a1, $a1, 4
			lw $a0 ($a1)
			syscall
			
			b print_loop
		
	integer_values:
		# new line
		li $v0, 4
		la $a0, newLine
		syscall
		
		# new line
		li $v0, 4
		la $a0, newLine
		syscall
	
		# print Integer values
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
		# print Sorted values
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