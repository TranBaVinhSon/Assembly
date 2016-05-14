.data
	line00: 	.asciiz "                                                          *************  \n "
	line01: 	.asciiz "**************                                           *3333333333333* \n "
	line02: 	.asciiz "*222222222222222*                                        *33333********  \n "
	line03: 	.asciiz "*22222******222222*                                      *33333*         \n "
   	line04: 	.asciiz "*22222*      *22222*                                     *33333********  \n "
	line05: 	.asciiz "*22222*       *22222*        *************               *3333333333333* \n "
	line06: 	.asciiz "*22222*       *22222*      **11111*****111*              *33333********  \n "
	line07: 	.asciiz "*22222*       *22222*    **11111****                     *33333*         \n "
	line08: 	.asciiz "*22222*       *22222*    *11111*                         *33333********  \n "
	line09:	.asciiz "*22222*******222222*     *11111*                         *3333333333333* \n "
	line10:	.asciiz "*2222222222222222*       *11111*                          *************  \n "
	line11:	.asciiz "***************          *11111*                                         \n "
	line12:	.asciiz "   -----                 *11111*                                         \n "
	line13:	.asciiz "  /  o o \\               *11111*********                                 \n "
	line14:	.asciiz "  \\    > /                 **111111***111*                               \n "
	line15:	.asciiz "   -----                      ***********                dce.hust.edu.vn \n "
endofline: .asciiz "\n"
	
ms1:	.asciiz " \n Input Color of D (0->9) : "
ms2:	.asciiz	" \n Input Color of C (0->9) : "
ms3:	.asciiz	" \n Input Color of E (0->9) : "
	
menu:	.asciiz "\n1. Show Image.\n2. Delete Color.\n3. Change Position.\n4. Change Color.\n5. Exit.\n>>> Chose Function: "
################################################################################
.text
	la	$s0, line00				# $s0 is address of line00
	la	$s1, line15				# $s1 is address of line15
	
	li	$s2, '2'				# s2 is colof of D
	li	$s3, '1'				# s3 is color of E
	li	$s4, '3'				# s4 if color of C
################################################################################
Menu:
	li	$v0, 4					# Menu :
	la	$a0, menu
	syscall
	
	li	$v0, 12					
	syscall
	move	$t9, $v0				# t9 = v0 = function was chosen
	
	beq	$t9, '5', EXIT
	beq	$t9, '1', Case1
	beq	$t9, '2', Case2
	beq	$t9, '3', Case3
	beq	$t9, '4', Case4	
	
	j 	Menu
################################################################################	
Case1:							# Show Image		
	
	li 	$v0, 4						# ShowImage \n
	la 	$a0, endofline
	syscall
	
	jal 	ShowImage				 
	j 	Menu
	
	ShowImage:								
		move 	$t0, $s0				# t0 is address of line00
		Case1_Loop:				
			li 	$v0, 4
			move 	$a0, $t0
			syscall
		
			addi 	$t0, $t0, 76			# t0 is next string, 76 is length of each string
			ble 	$t0, $s1, Case1_Loop 		# until to last line (s1)
	
		jr 	$ra
################################################################################
Case2:								# Delete color
	li 	$v0, 4						# print \n
	la	$a0, endofline
	syscall
	
	move 	$t8, $s0					# t8 = s0 = first line
	Case2_Loop:	
		move 	$t0, $t8				# t0 = t8 = first character int line
		li	$t7, 0					# count character
	
		CountCharacter:	
		lb 	$t3, 0($t0)				# t3 save character in line
	
		beq	$t3, $s2, PrintSpace			# if character if color, print space
		beq	$t3, $s3, PrintSpace
		beq	$t3, $s4, PrintSpace
	
		Print:  						# print character isn't color	
			li	$v0, 11
			move	$a0, $t3
			syscall
			j 	Continue
	
		PrintSpace:					# print space
			li 	$t4, ' '
			li	$v0, 11
			move	$a0, $t4 
			syscall
		Continue:	
			addi 	$t7, $t7, 1			# 
			addi	$t0, $t0, 1			# 
			ble 	$t7, 75, CountCharacter		# traverse all character in line
	
		addi 	$t8, $t8, 76				# traverse whole lines
		ble 	$t8, $s1, Case2_Loop
	
	j 	Menu
################################################################################ 	
Case3				:				# Change position
	li 	$v0, 4						# print \n
	la	$a0, endofline
	syscall
		
	move	$t8, $s0					# t8 = s0 = first line
	Case3_Loop1:
		li	$t0, '\0'				# t0 = null
		sb 	$t0, 23($t8)				# divide line into 3 strings
		sb	$t0, 48($t8)
	
		li	$t1, ' '				# delete enter at end of line
		sb	$t1, 73($t8)
	
		addi 	$t8, $t8, 76				# traverse whole lines
		ble 	$t8, $s1, Case3_Loop1
	
		move	$t8, $s0
	
	Case3_Loop2:						
		addi	$t8, $t8, 49				# Print E
	
		li 	$v0, 4
		move 	$a0, $t8
		syscall
								
		addi	$t8, $t8, -49				# Print C
		addi	$t8, $t8, 24
	
		li 	$v0, 4
		move 	$a0, $t8
		syscall
								
		addi	$t8, $t8, -24				# Print D
	
		li 	$v0, 4
		move 	$a0, $t8
		syscall
							
		li	$v0, 11					# Print \n
		li	$a0, '\n'
		syscall
	
		addi 	$t8, $t8, 76				# Traverse whole lines 
		ble 	$t8, $s1, Case3_Loop2

		# reset
		move	$t8, $s0				# t8 = s0 = first line
	Case3_Loop3:
		li	$t0, ' '				# delete \0
		sb 	$t0, 23($t8)
		sb	$t0, 48($t8)
		
		li	$t1, '\n'				# recover '\n	
		sb	$t1, 73($t8)
		
		addi 	$t8, $t8, 76				# traverse whole lines
		ble 	$t8, $s1, Case3_Loop3
	j 	Menu
###############################################################################
Case4				:				# Change color
	InputColorD:
		li 	$v0, 4					# print \n
		la 	$a0, ms1
		syscall
		
		li 	$v0, 12					
		syscall
		move	 $s5, $v0				# s5 is new color of D
	
		blt	$s5, '0', InputColorD			# check color (from 0 -> 9)
		bgt	$s5, '9', InputColorD
	InputColorC:
		li 	$v0, 4
		la 	$a0, ms2
		syscall
	
		li	$v0, 12					
		syscall
		move	$s6, $v0				# s6 is new color of C
	
		blt	$s6, '0', InputColorC			# check color (from 0 -> 9)
		bgt	$s6, '9', InputColorC
	InputColorE:
		li	$v0, 4
		la	$a0, ms3
		syscall
	
		li	$v0, 12					
		syscall
		move	$s7, $v0				# s7 is new color of E
	
		blt	$s7, '0', InputColorE			# check color (from 0->9)
		bgt	$s7, '9', InputColorE
	
	li 	$v0, 4						# print \n
	la 	$a0, endofline
	syscall	
	
	move 	$t8, $s0					# t8 = s0 = first line
	Case4_Loop:	
		move 	$t0, $t8	
		li	$t7, 0					
		x4:	
			lb 	$t3, 0($t0)			# t3 save character in line

		checkD:	
			bgt	$t7, 23, checkC	 		# if t7 > 23 check C
			beq	$t3, $s2, fixD
		checkC:
			bgt	$t7, 48, checkE			# i > 48 thi kt E
			beq	$t3, $s3, fixC
		checkE:
			beq	$t3, $s4, fixE
			j 	next4				# duyet ki tu tiep theo

	fixD:  		
		sb 	$s5, 0($t0)
		j 	next4
	fixC:
		sb 	$s6, 0($t0)
		j 	next4
	fixE:	
		sb 	$s7, 0($t0)
		j 	next4
	next4:	
		addi 	$t7, $t7, 1				# i = i + 1
		addi	$t0, $t0, 1				# duyet ki tu tiep thep
		ble 	$t7, 75, x4				# duyet den ki tu cuoi
			
		addi 	$t8, $t8, 76				# traversa whole lines
		ble 	$t8, $s1, Case4_Loop	
	
		jal 	ShowImage				
		# update color of character
		move	$s2, $s5
		move	$s3, $s6
		move	$s4, $s7
	j 	Menu
EXIT: