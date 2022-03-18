.data
	str1: .ascii "Hello, please enter your ID and name: \n"
	
	
	
	str: .space 20
	str2: .ascii "Okay, your ID and name is "
	
	str3: .ascii "\n"	
.text
	# prompt ID and name (print string)

	li $v0, 4
	la $a0, str1
	syscall
	
	# read ID (read integer)
	li $v0, 5
	syscall
	move $t1, $v0
	
	# read name
	li $v0, 8
	la $a0, str
	li $a1, 20
	syscall
	move $t0, $a0
	
	
	# display string
	li $v0, 4
	la $a0, str2
	syscall
	
	li $v0, 1
	la $a0, ($t1)
	syscall
	
	li $v0, 4
	la $a0, str3
	syscall
	
	li $v0, 4
	la $a0, ($t0)
	syscall	
		
	
	li $v0, 10
	syscall
	
	
	
	
	
	
	