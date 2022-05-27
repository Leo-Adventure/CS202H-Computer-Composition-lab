.data
	nums: .space 132
.text
	
main:
	li $v0, 5 # ��ȡ���Գ��� ��ȡ�� s3
	syscall
	move $s3, $v0
test1:
	bne  $s3, 0, test2
case1:
	
	li $v0, 5
	syscall
	move $t0, $v0 # t0 �洢 a
	li $v0, 1
	move $a0, $t0 # ��ʾ a
	syscall
	
	add $t1, $zero, $zero # t1 �洢 cnt ,��ʼ��Ϊ 0
	add $t2, $zero, $t0 #  t2 �洢 bit_num
	la $t3, nums # t3 �洢 nums ��ַ
	j CAL_TEST1 # jump to middle
CAL_LOOP1:
	sll $t5, $t1, 2 # t5 = cnt * 4
	add $t5, $t3, $t5 # t5 ����ǰ�����ַ
	andi $t6, $t2, 1 # t6 �洢����
	srl $t2, $t2, 1# bit_num / 2 �� t2 �洢��
	sw $t6, 0($t5)	# ����������0��1��ֱ�Ӱ������������鵱��
	addi $t1, $t1, 1 # cnt++
	
CAL_TEST1:
       	
	bne $t2, $zero, CAL_LOOP1 # ���� bit_num != 0 , $t4 = 1, ����whileѭ��
	
Judge:
	add $t8, $zero, $zero # i = 0�� t8 ���� i
	add $k0, $zero, $zero # flag = false, k0 ���� flag
	j test
loop:
	
	sll $a1, $t8, 2 # t8 �� i
	add $a1, $a1, $t3 # �ҵ���Ӧ�ĵ�ַ
	lw $a2, 0($a1) # nums[i]
	sub $t9, $t1, $t8 # cnt - i
	subi $t9, $t9, 1 # cnt - i - 1
	sll $t9, $t9, 2
	add $t9, $t9, $t3
	lw $a3, 0($t9) # nums[cnt - i - 1]
	beq $a2, $a3, jump
	add $k0, $zero, 1 # ֻҪ�в���ȵľ����� t9 = 1
jump:
	addi $t8, $t8, 1	
test:	
	bne $t8, $t1, loop
	
	beq $k0, 1, print_not
	# TODO: print_string(" is binary palindrome, ")
	j exit
print_not:
	# TODO: print_string(" is NOT binary palindrome, ")
	
test2:
	bne $s3, 1, test3
case2: 
	# ��ȡ a, b ������ʾ
	li $v0, 5
	syscall
	move $t0, $v0
	li $v0, 1
	move $a0, $t0
	syscall
	
	li $v0, 5
	syscall
	
	move $t1, $v0
	li $v0, 1
	move $a0, $t0
	syscall
	li $v0, 5
	syscall
test3:
	bne $s3, 2, test4
case3:
	and $t2, $t0, $t1
	li $v0, 1
	move $a0, $t2
	syscall
test4:
	bne $s3, 3, test5
case4:
	or $t2, $t0, $t1
	li $v0, 1
	move $a0, $t2
	syscall
test5:
	bne $s3, 4, test6
case5:
	xor $t2, $t0, $t1
	li $v0, 1
	move $a0, $t2
	syscall
test6:
	bne $s3, 5, test7
case6:
	add $s7, $zero, $zero
	
loop_shift_left1:
	sll $t0, $t0, 1
	addi $s7, $s7, 1
test_shift_left1:
	blt $s7, $t1, loop_shift_left1
	
	
test7:
	bne $s3, 6, test8
case7:
	add $s7, $zero, $zero
	
loop_shift_right1:
	srl $t0, $t0, 1
	addi $s7, $s7, 1
test_shift_right1:
	blt $s7, $t1, loop_shift_right1
	
test8:
	bne $s3, 7, exit
case8:
	add $s7, $zero, $zero
	
loop_shift_right2:
	sra $t0, $t0, 1
	addi $s7, $s7, 1
test_shift_right2:
	blt $s7, $t1, loop_shift_right2

exit:
	li $v0, 10
	syscall

	
	
