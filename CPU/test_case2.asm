.data # !!!remember to add 0x0000
 	# choose 8 * 9 + 10 bits as the space	
	num1: .space 80
	num2: .space 80
	num3: .space 80
	num4: .space 80
	
.text # !!!remember to add 0x0000

# £¡£¡£¡maybe remember to add "start:"

	li $v0, 5 # read test_num to $a0
	syscall
	move $v1, $v0
	
	la $s1, num1 # t1 store num1 as base address
	la $s2, num2 # t2 store num2 as base address
	la $s3, num3 # t3 store num3 as base address
	la $s4, num4 # t4 store num4 as base address
	
	add $t0, $zero, $zero # t0 as the counter i
loop1: # read the array's number
	li $v0, 5 # read the number, now the number is stored in v0
	syscall
	
	sll $t1, $t0, 2
	sll $t2, $t0, 2
	sll $t3, $t0, 2
	sll $t4, $t0, 2
	
	add $t1, $s1, $t1 # t1 as the current address of num1
	add $t2, $s2, $t2 # t2 as the current address of num2
	add $t3, $s3, $t3 # t3 as the current address of num3
	add $t4, $s4, $t4 # t4 as the current address of num4
	
	sw $v0, 0($t1) # save the number in num1[i]
	sw $v0, 0($t2) # save the number in num2[i]
	
	srl $t5, $v0, 7
	andi $t5, $t5, 1 # get the sign bit
	
	addi $t6, $zero, 1 # just for temp reg storing 1
	beq $t5, $t6, normal_store # if the most significant bit is 1, then it's negative
abnormal_store:
	sw $v0, 0($t3) # save the number in num3[i]
	sw $v0, 0($t4) # save the number in num4[i]
	addi $t0, $t0, 1
	j test1 # jump away normal_store

normal_store:
	# get the correct negative number: (num[i] & 0b1111111) - 128;
	andi $t6, $v0, 127
	addi $t6, $t6, -128
	sw $t6, 0($t3) # save the negative number in num3[i]
	sw $t6, 0($t4) # save the negative number in num4[i]
	addi $t0, $t0, 1
test1:# read number iteratively
	bne $t0, $v1, loop1 
	
	# after the read procedure, the t0 ~ t4 is free to use again
	# bubble sort for num2 and num4
	add $t6, $zero, $zero # reset tmp $t6 to zero (act as counter i)
	add $t7, $zero, $zero # reset tmp $t7 to zero (act as counter j)
	add $a1, $v1, -1 # inside_loop sentinel: test_num - 1 in a1
	
	j outside_test
	
	addi $t0, $t0, 1
test_loop1: 
	bne $t0, $v1, loop1
	
outside_loop: # outside loop for bubble sort
	addi $t6, $t6, 1
	add $t7, $zero, $zero
	
inside_loop: # inside loop for bubble sort

	# get num2[j]
	sll $t0, $t7, 2
	add $t0, $t0, $s2
	lw $t1, 0($t0) # load data from num2[j] in t1
	# get num2[j + 1]
	addi $t0, $t7, 1
	sll $t0, $t0, 2
	add $t0, $t0, $s2
	lw $t2, 0($t0) # load data from num2[j + 1] in t2
	
exchange_test1:
	blt $t1, $t2, exchange_test2 # if num2[j] < num2[j + 1], then jump out of following change part
	
	sw $t1, 0($t0) # num2[j + 1] = num2[j]
	# back to num2[j]
	sll $t0, $t7, 2
	add $t0, $t0, $s2
	sw $t2, 0($t0) # num2[j] = num2[j + 1]
	
exchange_test2:
	
	# get num4[j]
	sll $t0, $t7, 2
	add $t0, $t0, $s4
	lw $t1, 0($t0) # load data from num4[j] in t1
	# get num4[j + 1]
	addi $t0, $t7, 1
	sll $t0, $t0, 2
	add $t0, $t0, $s4
	lw $t2, 0($t0) # load data from num4[j + 1] in t2
	
	blt $t1, $t2, exchange_out # if num2[j] < num2[j + 1], then jump out of following change part
	
	sw $t1, 0($t0) # num4[j + 1] = num4[j]
	# back to num4[j]
	sll $t0, $t7, 2
	add $t0, $t0, $s4
	sw $t2, 0($t0) # num4[j] = num4[j + 1]

exchange_out:	
	
	addi $t7, $t7, 1

inside_test: # inside loop tester for bubble sort
	bne $t7, $a1, inside_loop
 
outside_test: # outside loop tester for bubble sort
	bne $t6, $v1, outside_loop	
	
	
	# After that, the registers except s1 ~ s4 (which save the base address of array) and a0(which save the size of array)are free to use
case4:
	# input the idx of array
	li $v0, 5
	syscall
	move $a1, $v0 # idx of array(1 or 3)
	addi $t2, $zero, 3 # t2 save immediate 3 for comparing
	beq $a1, $t2, case4_idx3
	
case4_idx1:
	lw $t0, 0($s2) # first number (least number)
	add $t2, $zero, $zero # initialization t2 to 0
	addi $t2, $v1, -1
	sll $t2, $t2, 2 # offset
	add $t2, $t2, $s2 # find the place
	lw $t1, 0($t2) # last number (largest number)
	xori $t0, $t0, 127# get negative first number
	addi $t0, $t0, 1
	addi $t0, $t0, -128
	add $t0, $t1, $t0 # t0 is the result
	li $v0, 1 # display the answer
	move $a0, $t0
	syscall 
	j case5
	
case4_idx3:
	lw $t0, 0($s4) # first number (least number)
	add $t2, $zero, $zero # initialization t2 to 0
	addi $t2, $v1, -1
	sll $t2, $t2, 2 # offset
	add $t2, $t2, $s2 # find the place
	lw $t1, 0($t4) # last number (largest number)
	xori $t0, $t0, 127# get negative first number
	addi $t0, $t0, -128
	addi $t0, $t0, 1
	add $t0, $t1, $t0 # t0 is the result
	li $v0, 1 # display the answer
	move $a0, $t0
	syscall 
	
case5:
	li $v0, 5
	syscall
	move $a1, $v0 # a1 save the idx of array
	li $v0, 5
	syscall
	move $a2, $v0 # a2 save the subscript of array
	addi $t2, $zero, 3 # t2 save immediate 3 for comparing
	beq $a1, $t2, case5_idx3
case5_idx1:
	sll $t0, $a2, 2 # find the place of required element
	add $t0, $t0, $s2
	
	lw $a0, 0($t0) # display it
	li $v0, 1
	syscall
	j case6	
case5_idx3:
	sll $t0, $a2, 2 # find the place of required element
	add $t0, $t0, $s4
	
	lw $a0, 0($t0) # display it
	li $v0, 1
	syscall

case6:
	li $v0, 5
	syscall
	move $a1, $v0 # save the idx of array in $a1
	li $v0, 5
	syscall
	move $a2, $v0 # save the subscript of array in $a2
	addi $t2, $zero, 2 # t2 save 2
	addi $t3, $zero, 3 # t3 save 3
	beq $a1, $t2, case6_idx2
	beq $a1, $t3, case6_idx3
	
	# After that, t2 and t3 are free to use
case6_idx1:
	sll $t0, $a2, 2
	add $t0, $t0, $s2
	lw $t4, 0($t0) # t4 save the target element
	
	# t2 save the signal bit and t3 save the exp bits
	slt $t2, $t4, $zero # if element is less than 0, then t2 is set to 1
	add $t3, $zero, $zero # initialize t3 to 0
	j test_shift_loop1
	
shift_loop1:
	addi $t3, $t3, 1 # exp += 1
	srl $t4, $t4, 1 # shift right 1 bit
	
test_shift_loop1:
	bne $t4, $zero, shift_loop1
	addi $t3, $t3, -1
	
	# display sign bit
	li $v0, 1
	move $a0, $t2
	syscall
	# display exp bits
	li $v0, 1
	move $a0, $t3
	syscall
	j case7
	
case6_idx2:
	sll $t0, $a2, 2
	add $t0, $t0, $s3
	lw $t4, 0($t0) # t4 save the target element
	
	# t2 save the signal bit and t3 save the exp bits
	slt $t2, $t4, $zero # if element is less than 0, then t2 is set to 1
	add $t3, $zero, $zero # initialize t3 to 0
	j test_shift_loop2
	
shift_loop2:
	addi $t3, $t3, 1 # exp += 1
	srl $t4, $t4, 1 # shift right 1 bit
	
test_shift_loop2:
	bne $t4, $zero, shift_loop2
	addi $t3, $t3, -1
	
	# display sign bit
	li $v0, 1
	move $a0, $t2
	syscall
	# display exp bits
	li $v0, 1
	move $a0, $t3
	syscall
	
	j case7
case6_idx3:
	sll $t0, $a2, 2
	add $t0, $t0, $s4
	lw $t4, 0($t0) # t4 save the target element
	
	# t2 save the signal bit and t3 save the exp bits
	slt $t2, $t4, $zero # if element is less than 0, then t2 is set to 1
	add $t3, $zero, $zero # initialize t3 to 0
	j test_shift_loop3
	
shift_loop3:
	addi $t3, $t3, 1 # exp += 1
	srl $t4, $t4, 1 # shift right 1 bit
	
test_shift_loop3:
	bne $t4, $zero, shift_loop3
	addi $t3, $t3, -1
	
	# display sign bit
	li $v0, 1
	move $a0, $t2
	syscall
	# display exp bits
	li $v0, 1
	move $a0, $t3
	syscall


case7:
	li $v0, 5
	syscall
	move $a2, $v0 # a2 save the subscript of array
	
	sll $t0, $a2, 2
	add $t0, $t0, $s1
	lw $t4, 0($t0) # t4 save the target element
	
case7_1:
	move $a0, $t4
	li $v0, 1
	syscall
case7_2:
	# t2 save the signal bit and t3 save the exp bits
	slt $t2, $t4, $zero # if element is less than 0, then t2 is set to 1
	add $t3, $zero, $zero # initialize t3 to 0
	j test_shift_loop
	
shift_loop:
	addi $t3, $t3, 1 # exp += 1
	srl $t4, $t4, 1 # shift right 1 bit
	
test_shift_loop:
	bne $t4, $zero, shift_loop
	addi $t3, $t3, -1
	
	# display sign bit
	li $v0, 1
	move $a0, $t2
	syscall
	# display exp bits
	li $v0, 1
	move $a0, $t3
	syscall
	
