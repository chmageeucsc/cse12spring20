# row = 1
addi $s1, $0, 1
# col = 1
addi $s2, $0, 1
# useIn = 3 // temporary
addi $s0, $0, 3
# num = 1
addi $s4, $0, 1
# useIn = 4 // temporary
addi $s6, $0, 4
# count for loop iterations
addi $s7, $0, 1

# for row in range (1, useIn + 1)
forRow:
	# $t0 = useIn + 1 // redacted for now
	# $s0 = useIn
	# $s1 = row
	#addi $t0, $s0, 1 // redacted
	beq $s1, $s6, exit
	nop
	
	# for col in range (1, row + 1)
	forCol1:
		# $t1 = row + 1
		# s2 = col
		add $t1, $s1, $s7
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
		
		#addi $s7, $s7, 1
		
 		addi $s1, $s1, 1
 		b forRow
 		nop
 		
 exit:
 	# Exit the program
	li $v0, 10
	syscall
 		
.data
newLine: .asciiz "\n"
		