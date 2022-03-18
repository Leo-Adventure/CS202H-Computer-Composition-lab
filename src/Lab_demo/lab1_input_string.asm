.data 
	str1: .ascii "Hello, please enter your name: \n"
	str2: .ascii "Okay, your name is: \n"
	str: .space 20

.text
	# prompt the input of name
	li $v0, 4
	la $a0, str1
	syscall
	
	# receive the input
	li $v0, 8
	#设置两个参数
	la $a0, str 
	li $a1, 20
	syscall
	
	# display
	li $v0, 4
	la $a0, str2
	syscall
	
	# exit
	li $v0, 10
	syscall
	
