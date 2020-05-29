##########################################################################
# Created by: Gee, Chantel
# chmagee
# 24 May 2020
#
# Assignment: Lab 5: Functions and Graphics
# CSE 12, Computer Systems and Assembly Language
# UC Santa Cruz, Spring 2020
#
# Description: This program will implement functions that perform
# 	some primitive graphics operations on a small simulated display.
#
# Notes: This program is intended to be run from the MARS IDE.
#
##########################################################################
#
# PSUEDOCODE for functions
#
# clear_bitmap
# push all s registers used in function
# load the originAddress into $s0
# load the max address (0xfffffffc) into $s1
# loop through and store the color ($a0) into
# every address from $s0 to $s1
# pop all s registers used in function
#-----------------------------------------------------------
# draw_pixel
# push all s registers used in function
# load coordinates into $s0
# getCoordinates and load into $s1 and $s2
# do the math to find the corresponding spot
# in the array ($s3)
# load the originAddress into $s4
# add $s4 and $s3 to correct spot in array
# pop all s registers used in function
#-----------------------------------------------------------
# get_pixel
# push all s registers used in function
# load coordinates into $s0
# getCoordinates and load into $s1 and $s2
# do the math to find the corresponding spot
# in the array ($s3)
# load the originAddress into $s4
# add $s4 and $s3 to correct spot in array 
# load s4 into $v0
# pop all s registers used in function
#-----------------------------------------------------------
# draw_solid_circle
#-----------------------------------------------------------
# draw_circle
#-----------------------------------------------------------
# draw_circle_pixels
#-----------------------------------------------------------

# Macro that stores the value in %reg on the stack 
#  and moves the stack pointer.
.macro push(%reg)
	subi $sp $sp 4
	sw %reg 0($sp)
.end_macro 

# Macro takes the value on the top of the stack and 
#  loads it into %reg then moves the stack pointer.
.macro pop(%reg)
	lw %reg 0($sp)
	addi $sp $sp 4
.end_macro

# Macro that takes as input coordinates in the format
# (0x00XX00YY) and returns 0x000000XX in %x and 
# returns 0x000000YY in %y
.macro getCoordinates(%input %x %y)
	srl %x %input 16
	sll %y %input 16
	srl %y %y 16
.end_macro

# Macro that takes Coordinates in (%x,%y) where
# %x = 0x000000XX and %y= 0x000000YY and
# returns %output = (0x00XX00YY)
.macro formatCoordinates(%output %x %y)
	add %output $0 %x
	sll %output %output 16
	add %output %output %y
.end_macro 


.data
originAddress: .word 0xFFFF0000

.text
j done
    
    done: nop
    li $v0 10 
    syscall

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#  Subroutines defined below
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#*****************************************************
#Clear_bitmap: Given a color, will fill the bitmap display with that color.
#   Inputs:
#    $a0 = Color in format (0x00RRGGBB) 
#   Outputs:
#    No register outputs
#    Side-Effects: 
#    Colors the Bitmap display all the same color
#*****************************************************
clear_bitmap: nop
	push($ra)
	push($s0)
	push($s1)
	lw $s0 originAddress
	lw $s1 0xfffffffc
	cb_loop:
		beq $s0 $s1 cb_loop_end
		push($s0)
		sw $a0, ($s0)
		pop($s0)
		addi $s0 $s0 4
		b cb_loop
	cb_loop_end:
	pop($s1)
	pop($s0)
	pop($ra)
	jr $ra
	
#*****************************************************
# draw_pixel:
#  Given a coordinate in $a0, sets corresponding value
#  in memory to the color given by $a1	
#-----------------------------------------------------
#   Inputs:
#    $a0 = coordinates of pixel in format (0x00XX00YY)
#    $a1 = color of pixel in format (0x00RRGGBB)
#   Outputs:
#    No register outputs
#*****************************************************
draw_pixel: nop
	push($ra)
	push($a0)
	push($a1)
	push($s0)
	push($s1)
	push($s2)
	push($s3)
	push($s4)
	la $s0 ($a0)
	getCoordinates($s0, $s1, $s2)
	mul $s3 $s2 128
	add $s3 $s3 $s1
	mul $s3 $s3 4
	lw $s4 originAddress
	add $s4 $s4 $s3
	sw $a1 ($s4)
	pop($s4)
	pop($s3)
	pop($s2)
	pop($s1)
	pop($s0)
	pop($a1)
	pop($a0)
	pop($ra)
	jr $ra
	
#*****************************************************
# get_pixel:
#  Given a coordinate, returns the color of that pixel	
#-----------------------------------------------------
#   Inputs:
#    $a0 = coordinates of pixel in format (0x00XX00YY)
#   Outputs:
#    Returns pixel color in $v0 in format (0x00RRGGBB)
#*****************************************************
get_pixel: nop
	push($ra)
	push($a0)
	push($s0)
	push($s1)
	push($s2)
	push($s3)
	push($s4)
	la $s0 ($a0)
	getCoordinates($s0, $s1, $s2)
	mul $s3 $s2 128
	add $s3 $s3 $s1
	mul $s3 $s3 4
	lw $s4 originAddress
	add $s4 $s4 $s3
	lw $v0, ($s4)
	pop($s4)
	pop($s3)
	pop($s2)
	pop($s1)
	pop($s0)
	pop($a0)
	pop($ra)
	jr $ra

#***********************************************
# draw_solid_circle:
#  Considering a square arround the circle to be drawn  
#  iterate through the square points and if the point 
#  lies inside the circle (x - xc)^2 + (y - yc)^2 = r^2
#  then plot it.
#-----------------------------------------------------
# draw_solid_circle(int xc, int yc, int r) 
#    xmin = xc-r
#    xmax = xc+r
#    ymin = yc-r
#    ymax = yc+r
#    for (i = xmin; i <= xmax; i++) 
#        for (j = ymin; j <= ymax; j++) 
#            a = (i - xc)*(i - xc) + (j - yc)*(j - yc)	 
#            if (a < r*r ) 
#                draw_pixel(x,y) 	
#-----------------------------------------------------
#   Inputs:
#    $a0 = coordinates of circle center in format (0x00XX00YY)
#    $a1 = radius of the circle
#    $a2 = color in format (0x00RRGGBB)
#   Outputs:
#    No register outputs
#***************************************************
draw_solid_circle: nop
	push($ra)
	push($a0)
	push($a1)
	push($a2)
	push($s0)
	push($s1)
	push($s2)
	push($s4)
	push($s5)
	push($s6)
	push($s7)
	la $s0, ($a0)
	getCoordinates($s0, $s1, $s2)
	sub $s4, $s1, $a1		# xmin
	add $s5, $s1, $a1		# xmax
	sub $s6, $s2, $a1		# ymin
	add $s7, $s2, $a1		# ymax
	mul $t3, $a1, $a1
	add $t4, $0, $s4		# original xmin
	add $t5, $0, $s6		# original ymin
	forx:
		bgt $s4, $s5 end_dsc
		fory:
			bgt $s6, $s7, forx1		# if ymin > ymax, start next for x loop
			sub $t0, $s4, $s1		# $t0 = (xmin - xc)^2
			mul $t0, $t0, $t0
			sub $t1, $s6, $s2		# $t1 = (ymin - yc)^2
			mul $t1, $t1, $t1
			add $t2, $t0, $t1		# $t2 (or a) = (xmin - xc)^2 + (ymin - yc)^2
			blt $t2, $t3, dp		# if a < r^2, draw pixel
			addi $s6, $s6, 1
			b fory
				
	
	forx1:
		addi $s4 $s4 1
		add $s6, $0, $t5		# reset counter for fory loop
		b forx	
		
		dp:
			addi $s6 $s6 1
			push($a0)
			push($a1)
			la $a1, ($a2)
			push($ra)
			push($s0)
			push($s1)
			push($s2)
			push($s4)
			push($s6)
			formatCoordinates($a0, $s4, $s6)
			jal draw_pixel
			pop($s6)
			pop($s4)
			pop($s2)
			pop($s1)
			pop($s0)
			pop($ra)
			pop($a1)
			pop($a0)
			b fory
		
	end_dsc:
	add $s4, $0, $0			# reset counter for forx loop (just in case)
	pop($s7)
	pop($s6)
	pop($s5)
	pop($s4)
	pop($s2)
	pop($s1)
	pop($s0)
	pop($a2)
	pop($a1)
	pop($a0)
	pop($ra)
	jr $ra
		
#***********************************************
# draw_circle:
#  Given the coordinates of the center of the circle
#  plot the circle using the Bresenham's circle 
#  drawing algorithm 	
#-----------------------------------------------------
# draw_circle(xc, yc, r) 
#    x = 0 
#    y = r 
#    d = 3 - 2 * r 
#    draw_circle_pixels(xc, yc, x, y) 
#    while (y >= x) 
#        x=x+1 
#        if (d > 0) 
#            y=y-1  
#            d = d + 4 * (x - y) + 10 
#        else
#            d = d + 4 * x + 6 
#        draw_circle_pixels(xc, yc, x, y) 	
#-----------------------------------------------------
#   Inputs:
#    $a0 = coordinates of the circle center in format (0x00XX00YY)
#    $a1 = radius of the circle
#    $a2 = color of line in format (0x00RRGGBB)
#   Outputs:
#    No register outputs
#***************************************************
draw_circle: nop
	push($ra)
	push($s5)
	push($s6)
	push($s7)
	add $s5 $0 $0		# x = 0
	add $s6 $0 $a1		# y = r
	mul $t9 $s6 2
	addi $t8 $0 3
	sub $s7 $t8 $t9		# d = 3 - 2 * r
	# insert draw circle pixels here
	while_yx:
		blt $s6 $s5 end_dc
		addi $s5 $s5 1
		while_if:
			ble $s7 $0 while_else
			subi $s6 $s6 1
			sub $t7 $s5 $s6
			mul $t7 $t7 4
			add $s7 $s7 $t7
			addi $s7 $s7 10
			b while_yx
		while_else:
			mul $t7 $s5 4
			add $s7 $s7 $t7
			addi $s7 $s7 6
			b while_yx
	end_dc:
		# insert draw circle pixels here
	pop($s7)
	pop($s6)
	pop($s5)
	pop($ra)
	jr $ra
	
#*****************************************************
# draw_circle_pixels:
#  Function to draw the circle pixels 
#  using the octans' symmetry
#-----------------------------------------------------
# draw_circle_pixels(xc, yc, x, y)  
#    draw_pixel(xc+x, yc+y) 
#    draw_pixel(xc-x, yc+y)
#    draw_pixel(xc+x, yc-y)
#    draw_pixel(xc-x, yc-y)
#    draw_pixel(xc+y, yc+x)
#    draw_pixel(xc-y, yc+x)
#    draw_pixel(xc+y, yc-x)
#    draw_pixel(xc-y, yc-x)
#-----------------------------------------------------
#   Inputs:
#    $a0 = coordinates of circle center in format (0x00XX00YY)
#    $a1 = color of pixel in format (0x00RRGGBB)
#    $a2 = current x value from the Bresenham's circle algorithm
#    $a3 = current y value from the Bresenham's circle algorithm
#   Outputs:
#    No register outputs	
#*****************************************************
draw_circle_pixels: nop
	push($ra)
	
	pop($ra)
	jr $ra
