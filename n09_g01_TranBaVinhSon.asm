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
.text
#--------------------------------------------------------------------------------------------	
#define
	la	$s0, line00			# $s0 chua dia chi cua xau a1
	la	$s1, line15			# $s1 chua dia chi cua xau a16
	
	
	li	$s2, '2'			# ki tu mau chu D
	li	$s3, '1'			# ki tu mau chu E
	li	$s4, '3'			# ki tu mau chu C
#---------------------------------------------------------------------------------------------		
	
#in MENU

MENU:
	li	$v0, 4
	la	$a0, menu
	syscall
	
	li	$v0, 12				# Nhap lua chon
	syscall
	move	$t9, $v0			# t9 chua lua chon 
	
	beq	$t9, '5', EXIT
	beq	$t9, '1', Case1
	beq	$t9, '2', Case2
	beq	$t9, '3', Case3
	beq	$t9, '4', Case4	
	
	j MENU
#-----------------------------------------------------------------------------------------------

Case1:						# in anh			
	
	li 	$v0, 4				# in messsage1
	la 	$a0, endofline
	syscall
	
	jal 	print				# goi thu tuc in 
	j MENU
	
print:						# thu tuc in 		
	move 	$t0, $s0			# in xau a1->a16
	
loop:				
	li 	$v0, 4
	move 	$a0, $t0
	syscall
	
	addi 	$t0, $t0, 76	# in xau tiep theo
	ble 	$t0, $s1, loop	# in den xau cuoi thi dung	
	
	jr 	$ra
#-----------------------------------------------------------------------------------------------------
Case2:				# xoa mau

	li 	$v0, 4		# in ra message2
	la	$a0, endofline
	syscall
	
	move 	$t8, $s0	# t8 chua dia chi xau dau tien
	
loop2:	
	move 	$t0, $t8	
	li	$t7, 0		# $t7 = i, i = 0
	
x:	lb 	$t3, 0($t0)	# t3 chua ki tu trong xau
	
	
	beq	$t3, $s2, inspace# kiem tra neu la ki tu mau thi in ra space
	beq	$t3, $s3, inspace
	beq	$t3, $s4, inspace
	
in:  				# in ki tu khong phai ki tu mau	
	li	$v0,11
	move	$a0, $t3
	syscall
	j next
	
inspace:			# in space
	li 	$t4, ' '
	li	$v0,11
	move	$a0,$t4 
	syscall
next:	
	addi 	$t7, $t7, 1	# i = i + 1
	addi	$t0, $t0, 1	# duyet ki tu tiep thep
	ble 	$t7, 75, x	# duyet den ki tu cuoi
	
	
	addi 	$t8, $t8, 76	# duyet den xau tiep theo
	ble 	$t8, $s1, loop2
	
	j MENU
#---------------------------------------------------------------------------------------------------------------- 	
Case3:				# dao chu
	li 	$v0, 4			# in ra message2
	la	$a0, endofline
	syscall
	
		
# chinh sua	
	move	$t8, $s0	# t8 chua dia chi xau dau tien
loopx:
	li	$t0, '\0'	# them ki tu ket thuc
	sb 	$t0, 23($t8)
	sb	$t0, 48($t8)
	
	li	$t1, ' '	# xoa ki tu  enter
	sb	$t1, 73($t8)
	
	addi 	$t8, $t8, 76	# duyet den xau tiep theo
	ble 	$t8, $s1, loopx
	
# in anh
	move	$t8, $s0
	
loop3:				
	
	
# in E	
	addi	$t8,$t8, 49		
	
	li 	$v0,4
	move 	$a0, $t8
	syscall
	
#in C
	addi	$t8,$t8,-49
	addi	$t8,$t8, 24
	
	li 	$v0,4
	move 	$a0, $t8
	syscall
	
#in D
	addi	$t8,$t8,-24
	
	li 	$v0,4
	move 	$a0, $t8
	syscall
	
	
#in enter
	li	$v0,11
	li	$a0, '\n'
	syscall
	

	addi 	$t8, $t8, 76	# duyet tat ca cac xau 
	ble 	$t8, $s1, loop3
	
# reset

	move	$t8, $s0	# t8 chua dia chi xau dau tien
loopxx:
	li	$t0, ' '	# xoa ki tu ket thuc
	sb 	$t0, 23($t8)
	sb	$t0, 48($t8)
	
	li	$t1, '\n'	# khoi phuc ki tu  enter
	sb	$t1, 73($t8)
	
	addi 	$t8, $t8, 76	# duyet den xau tiep theo
	ble 	$t8, $s1, loopxx

	
	j MENU
#-------------------------------------------------------------------------------------------------------------------
Case4:				# doi mau


# nhap mau cho chu D
nhapD:
	li 	$v0, 4		#in message3
	la 	$a0, ms1
	syscall
	
	
	li 	$v0, 12		# s5 chua ki tu mau cua chu D
	syscall
	move	 $s5, $v0
	
	blt	$s5, '0', nhapD	# kt ki tu mau 0->9
	bgt	$s5, '9', nhapD
	
# nhap mau cho chu C	
nhapC:

	li 	$v0, 4
	la 	$a0, ms2
	syscall
	
	li	$v0, 12		# s6 chua ki tu mau cua chu C
	syscall
	move	$s6, $v0
	
	blt	$s6, '0', nhapC	# kt ki tu mau 0->9
	bgt	$s6, '9', nhapC
	
# nhap mau cho chu E
nhapE:
	li	$v0, 4
	la	$a0, ms3
	syscall
	
	li	$v0, 12		# s7 chua ki tu mau cua chu E
	syscall
	move	$s7, $v0
	
	blt	$s7, '0', nhapE	# kt ki tu mau 0->9
	bgt	$s7, '9', nhapE
	
# in message4
	li 	$v0, 4		
	la 	$a0, endofline
	syscall	
	
# bat dau doi mau

	move 	$t8, $s0	# t8 chua dia chi xau dau tien
	
loop4:	
	move 	$t0, $t8	
	li	$t7, 0		# $t7 = i, i = 0
	
x4:	
	lb 	$t3, 0($t0)	# t3 chua ki tu trong xau

checkD:	
	bgt	$t7, 23, checkC	# i > 23 thi kt C
	beq	$t3, $s2, fixD
	
checkC:
	bgt	$t7, 48, checkE	# i > 48 thi kt E
	beq	$t3, $s3, fixC

checkE:
	beq	$t3, $s4, fixE
	j 	next4		# duyet ki tu tiep theo
	
fixD:  		
	sb 	$s5, 0($t0)
	j next4
	
	
fixC:
	sb 	$s6, 0($t0)
	j next4
	
fixE:	
	sb 	$s7, 0($t0)
	j next4
	
next4:	
	addi 	$t7, $t7, 1	# i = i + 1
	addi	$t0, $t0, 1	# duyet ki tu tiep thep
	ble 	$t7, 75, x4	# duyet den ki tu cuoi
			
	
	addi 	$t8, $t8, 76	# duyet den xau tiep theo
	ble 	$t8, $s1, loop4
	
	jal 	print		# goi thu stuc print

# update ki tu mau

	move	$s2, $s5
	move	$s3, $s6
	move	$s4, $s7
		
				
	j MENU


EXIT:

	
	
	
