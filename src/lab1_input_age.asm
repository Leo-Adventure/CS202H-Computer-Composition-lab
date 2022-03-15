.data
	str1: .ascii "Hello, please enter your age:\n"
	str2: .ascii "Okay, your age is: \n"
	
.text
	# prompt input age
	li $v0, 4
	la $a0, str1
	syscall
	
	# read input age
	li $v0, 5
	syscall 
	move $t1, $v0
	
	#display your age
	li $v0, 4
	la $a0, str2
	syscall
	
	li $v0, 1
	move $a0, $t1
	syscall
	
	li $v0, 10
	syscall
	
	