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
	beq	$a1, -2, ExitProgram			# if cancel, Exit program
	beq	$a1, -3, Menu			# if Ok without number, input again
	
	slti 	$t1, $a0, 5			# if v0 < 5, t1 = 1 else t1 = 0
	slti	$t2, $a0, 1   			# if v0 < 1, t2 = 1 else t2 = 0	
	beqz 	$t1, Menu			# if t1 = 0 ( > 4) try input again
	bnez 	$t2, Menu			# if t2 = 1 (< 0)  try input again
	move 	$t9, $a0			# t9 = a0 = (function was chosen)	
	 
	Case1:
		bne	$t9, 1, Case2
		jal	Reset
		add	$a0, $s0, $zero
		jal	ShowImage
		j 	Menu
	Case2:
		bne	$t9, 2, Case3
	Case3:
		bne	$t9, 3, Case4
	Case4:
		
	
	
	j	ExitProgram
	
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
	addi	$sp, $sp, -4
	sw	$ra, 0($sp)
	add	$t0, $zero, $a0
	li	$t1, 0
	li	$t2, 16
	ShowImage_Loop_1:
		slt 	$t3, $t1, $t2		
		beq 	$t3, $zero, ShowImage_Exit_Loop_1
		sll	$t3, $t1, 2			
		add	$t3, $t3,$t0		
		lw 	$a0, 0($t3)			
		#jal	printf
		li 	$a0, '\n'
		#jal 	putchar			
		addi 	$t1, $t1, 1
		j 	ShowImage_Loop_1
	ShowImage_Exit_Loop_1:
		lw 	$ra, 0($sp)
		addi 	$sp, $sp, 4
		jr 	$ra
DeleteColor:
	add	$t0, $zero, $a0
	li	$t1, 0
	li	$t2, 16
	
	DeleteColor_Loop_1:
		slt	$t3, $t1, $t2
		beq	$t3, $zero, DeleteColor_Exit_Loop_1
		sll	$t3, $t1, 2
		add	$t3, $t3, $t0
		lw	$t3, 0($t3)
	
	DeleteColor_Loop_2:
		lb	$t4, 0($t3)
		beq	$t4, 0, DeleteColor_Exit_Loop_2
		blt	$t4, 0, Continue
		bgt	$t4, 9, Continue
		li	$t4, ' '
		sb	$t4, 0($t3)
		
	Continue:
		addi	$t3, $t3, 1
		j 	DeleteColor_Loop_2
	
	DeleteColor_Exit_Loop_2:
		addi	$t1, $t1, 1
		j	DeleteColor_Loop_1
	DeleteColor_Exit_Loop_1:
		jr	$ra
ChangeColor:
	#line01
		lb $t0,4($a0)			
		addi $t1,$t0,42
		addi $t2,$t0,55
	line01e:
		addi $t1,$t1,1
		sb $a3,0($t1)
		beq $t1,$t2,done01e
		j line01e
	done01e:
	
	#line02
		lw $t0,8($a0)
		addi $t1,$t0,0
		addi $t2,$t0,15
	line02d:
		addi $t1,$t1,1
		sb $a1,0($t1)
		beq $t1,$t2,done02d
		j line02d
	done02d:
		addi $t1,$t0,42
		addi $t2,$t0,47
	line02e:
		addi $t1,$t1,1
		sb $a3,0($t1)
		beq $t1,$t2,done02e
		j line02e
	done02e:
	
	#line03
		lw $t0,12($a0)
		addi $t1,$t0,0
		addi $t2,$t0,5
	line03d:
		addi $t1,$t1,1
		sb $a1,0($t1)
		beq $t1,$t2,done03d
		j line03d
	done03d:
		addi $t1,$t0,11
		addi $t2,$t0,17
	line03d1:
		addi $t1,$t1,1
		sb $a1,0($t1)
		beq $t1,$t2,done03d1
		j line03d1
	done03d1:
		addi $t1,$t0,42
		addi $t2,$t0,47
	line03e:
		addi $t1,$t1,1
		sb $a3,0($t1)
		beq $t1,$t2,done03e
		j line03e
	done03e:
	
	#line04
		lw $t0,16($a0)
		addi $t1,$t0,0
		addi $t2,$t0,5
	line04d:
		addi $t1,$t1,1
		sb $a1,0($t1)
		beq $t1,$t2,done04d
		j line04d
	done04d:
		addi $t1,$t0,13
		addi $t2,$t0,18
	line04d1:
		addi $t1,$t1,1
		sb $a1,0($t1)
		beq $t1,$t2,done04d1
		j line04d1
	done04d1:
		addi $t1,$t0,42
		addi $t2,$t0,47
	line04e:
		addi $t1,$t1,1
		sb $a3,0($t1)
		beq $t1,$t2,done04e
		j line04e
	done04e:
	
	#line05
		lw $t0,20($a0)
		addi $t1,$t0,0
		addi $t2,$t0,5
	line05d:
		addi $t1,$t1,1
		sb $a1,0($t1)
		beq $t1,$t2,done05d
		j line05d
	done05d:
		addi $t1,$t0,14
		addi $t2,$t0,19
	line05d1:
		addi $t1,$t1,1
		sb $a1,0($t1)
		beq $t1,$t2,done05d1
		j line05d1
	done05d1:
  	  addi $t1,$t0,42
		addi $t2,$t0,55
	line05e:
		addi $t1,$t1,1
		sb $a3,0($t1)
		beq $t1,$t2,done05e
		j line05e
	done05e: 
	
	#line06
		lw $t0,24($a0)
		addi $t1,$t0,0
		addi $t2,$t0,5
	line06d:
		addi $t1,$t1,1
		sb $a1,0($t1)
		beq $t1,$t2,done06d
		j line06d
	done06d:
		addi $t1,$t0,14
		addi $t2,$t0,19
	line06d1:
		addi $t1,$t1,1
		sb $a1,0($t1)
		beq $t1,$t2,done06d1
		j line06d1
	done06d1:
		addi $t1,$t0,26
		addi $t2,$t0,31
	line06c:
		addi $t1,$t1,1
		sb $a2,0($t1)
		beq $t1,$t2,done06c
		j line06c
	done06c:
   	 addi $t1,$t0,36
		addi $t2,$t0,39
	line06c1:
		addi $t1,$t1,1
		sb $a2,0($t1)
		beq $t1,$t2,done06c1
		j line06c1    
	done06c1:        
  	  addi $t1,$t0,42
		addi $t2,$t0,47
	line06e:
		addi $t1,$t1,1
		sb $a3,0($t1)
		beq $t1,$t2,done06e
		j line06e
	done06e:    
	
	#line07
		lw $t0,28($a0)
		addi $t1,$t0,0
		addi $t2,$t0,5
	line07d:
		addi $t1,$t1,1
		sb $a1,0($t1)
		beq $t1,$t2,done07d
		j line07d
	done07d:
			addi $t1,$t0,14
		addi $t2,$t0,19
	line07d1:
		addi $t1,$t1,1
		sb $a1,0($t1)
		beq $t1,$t2,done07d1
		j line07d1
	done07d1:
		addi $t1,$t0,24
		addi $t2,$t0,28
	line07c:
		addi $t1,$t1,1
		sb $a2,0($t1)
		beq $t1,$t2,done07c
		j line07c
	done07c:     
    	addi $t1,$t0,42
		addi $t2,$t0,47
	line07e:
		addi $t1,$t1,1
		sb $a3,0($t1)
		beq $t1,$t2,done07e
		j line07e
	done07e:  
	
	#line08
		lw $t0,32($a0)
		addi $t1,$t0,0
		addi $t2,$t0,5
	line08d:
		addi $t1,$t1,1
		sb $a1,0($t1)
		beq $t1,$t2,done08d
		j line08d
	done08d:
		addi $t1,$t0,13
		addi $t2,$t0,19
	line08d1:
		addi $t1,$t1,1
		sb $a1,0($t1)
		beq $t1,$t2,done08d1
		j line08d1
	done08d1:
		addi $t1,$t0,23
		addi $t2,$t0,27
	line08c:
		addi $t1,$t1,1
		sb $a2,0($t1)
		beq $t1,$t2,done08c
		j line08c
	done08c:     
  	  addi $t1,$t0,42
		addi $t2,$t0,47
	line08e:
		addi $t1,$t1,1
		sb $a3,0($t1)
		beq $t1,$t2,done08e
		j line08e
	done08e:
	
	#line09
		lw $t0,36($a0)
		addi $t1,$t0,0
		addi $t2,$t0,5
	line09d:
		addi $t1,$t1,1
		sb $a1,0($t1)
		beq $t1,$t2,done09d
		j line09d
	done09d:
		addi $t1,$t0,12
		addi $t2,$t0,18
	line09d1:
		addi $t1,$t1,1
		sb $a1,0($t1)
		beq $t1,$t2,done09d1
		j line09d1
	done09d1:
		addi $t1,$t0,22
		addi $t2,$t0,27
	line09c:
		addi $t1,$t1,1
		sb $a2,0($t1)
		beq $t1,$t2,done09c
		j line09c
	done09c:     
   	 addi $t1,$t0,42
		addi $t2,$t0,55
	line09e:
		addi $t1,$t1,1
		sb $a3,0($t1)
		beq $t1,$t2,done09e
		j line09e
	done09e:       
	
	#line10
		lw $t0,40($a0)
		addi $t1,$t0,0
		addi $t2,$t0,16
	line10d:
		addi $t1,$t1,1
		sb $a1,0($t1)
		beq $t1,$t2,done10d
		j line10d
	done10d:
		addi $t1,$t0,22
		addi $t2,$t0,27
	line10c:
		addi $t1,$t1,1
		sb $a2,0($t1)
		beq $t1,$t2,done10c
		j line10c
	done10c:  
	   
	#line11
		lw $t0,44($a0)
		addi $t1,$t0,22
		addi $t2,$t0,27
	line11c:
		addi $t1,$t1,1
		sb $a2,0($t1)
		beq $t1,$t2,done11c
		j line11c
	done11c:     
	
	#line12
		lw $t0,48($a0)
		addi $t1,$t0,23
		addi $t2,$t0,27
	line12c:
		addi $t1,$t1,1
		sb $a2,0($t1)
		beq $t1,$t2,done12c
		j line12c
	done12c: 

	#line13
		lw $t0,52($a0)
		addi $t1,$t0,24
		addi $t2,$t0,28
	line13c:
		addi $t1,$t1,1
		sb $a2,0($t1)
		beq $t1,$t2,done13c
		j line13c
	done13c:  	
	
	#line14
		lw $t0,56($a0)
		addi $t1,$t0,26
		addi $t2,$t0,32
	line14c:
		addi $t1,$t1,1
		sb $a2,0($t1)
		beq $t1,$t2,done14c
		j line14c
	done14c:  
		addi $t1,$t0,35
		addi $t2,$t0,38
	line14c1:
		addi $t1,$t1,1
		sb $a2,0($t1)
		beq $t1,$t2,done14c1
		j line14c1
	done14c1:	

		jr $ra
Reset:
	addi	$sp, $sp, -4
	sb	$ra, 0($sp)
	
	add 	$a0, $s0, $zero
	li	$a1, 2					# return 2 to D
	li	$a2, 1					# return 1 to C
	li	$a3, 3					# return 3 to E
	jal	ChangeColor
	
	lw	$ra, 0($sp)
	addi	$sp, $sp, 4
	jr	$ra
	
ExitProgram:
	     
