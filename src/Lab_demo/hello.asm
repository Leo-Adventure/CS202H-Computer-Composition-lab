.data
	str1: .ascii "Hello! Please input your ID: \0"
	str2: .ascii "\n"
	str3: .ascii "And your name is: "
	
.text
	# ��ӭ����
	li $v0, 4
	la $a0, str1
	syscall
	
	# ��ȡ����
	li $v0, 5
	
	syscall
	move $a0, $v0
	
	li $v0, 1
	syscall	
	
	
	li $v0, 10
	syscall
	
