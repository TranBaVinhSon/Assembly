.data 

line00: .asciiz "                                           ************* "
line01: .asciiz "**************                            *3333333333333*"
line02: .asciiz "*222222222222222*                         *33333******** "
line03: .asciiz "*22222******222222*                       *33333*        "
line04: .asciiz "*22222*      *22222*                      *33333******** "
line05: .asciiz "*22222*       *22222*      *************  *3333333333333*"
line06: .asciiz "*22222*       *22222*  l **11111*****111* *33333******** "
line07: .asciiz "*22222*       *22222*  **1111**       **  *33333*        "
line08: .asciiz "*22222*      *222222*  *1111*             *33333******** "
line09: .asciiz "*22222*******222222*  *11111*             *3333333333333*"
line10: .asciiz "*2222222222222222*    *11111*              ************* "
line11: .asciiz "***************       *11111*                            "
line12: .asciiz "      ---              *1111**                           "	
line13: .asciiz "    / o o \\             *1111****   *****               "
line14: .asciiz "    \\  >  /              **111111***111*                "
line15: .asciiz "     -----                 ***********    dce.hust.edu.vn"

menu:	.asciiz "\n  1. Show DCE.\n  2. Delete Color.\n  3. Change position ECD.\n  4. Change color.\n >>> Chose function\n\n"
chose:	.asciiz "Please chose function :"
error:	.asciiz "Please try again!" 

arr :	.space 100

.text

Start:
	jal	LoadImage
	la	$s0, arr

Menu:
	li	$v0, 4				# Print menu
	la	$a0, menu
	syscall
	
	li   	$v0, 51				# Show dialog for chose function
	la   	$a0, chose
	syscall
	# check input
	beq	$a1, -1, Menu			# if not integer
	beq	$a1, -2, Exit			# if cancel, Exit program
	beq	$a1, -3, Menu			# if Ok without number, input again
	
	slti 	$t1, $a0, 5			# if v0 < 5, t1 = 1 else t1 = 0
	slti	$t2, $a0, 1   			# if v0 < 1, t2 = 1 else t2 = 0	
	beqz 	$t1, Menu			# if t1 = 0 ( > 4) try input again
	bnez 	$t2, Menu			# if t2 = 1 (< 0)  try input again
	move 	$t9, $a0			# t9 = a0 = (function was chosen)	
	 
	Case1:
		bne	$t9, 1, Case2
		
		j Menu
	Case2:
		bne	$t9, 2, Case3
	Case3:
		bne	$t9, 3, Case4
	Case4:
		
	
	
	j	Exit
	
LoadImage:
	la	$t0, arr
	
	la	$t1, line00
	sb	$t1, 0($t0)
	la	$t1, line01
	sb	$t1, 4($t0)
	la	$t1, line02
	sb	$t1, 8($t0)
	la	$t1, line03
	sb	$t1, 12($t0)
	la	$t1, line04
	sb	$t1, 16($t0)
	la	$t1, line05
	sb	$t1, 20($t0)
	la	$t1, line06
	sb	$t1, 24($t0)
	la	$t1, line07
	sb	$t1, 28($t0)
	la	$t1, line08
	sb	$t1, 32($t0)
	la	$t1, line09
	sb	$t1, 36($t0)
	la	$t1, line10
	sb	$t1, 40($t0)
	la	$t1, line11
	sb	$t1, 44($t0)
	la	$t1, line12
	sb	$t1, 48($t0)
	la	$t1, line13
	sb	$t1, 52($t0)
	la	$t1, line14
	sb	$t1, 56($t0)
	la	$t1, line15
	sb	$t1, 60($t0)
	
	jr 	$ra
	
ShowImage:

Reset:
	
Exit:
	     
