.data
	str1: .asciiz "13/4 quotient is : "
	str2: .asciiz " , remander is : "
.text
main:
	# 打印字符串
	la $a0, str1
	li $v0, 4
	syscall
	
	# 除法，商保存在lo，余数保存在hi
	# 之后打印字符串
	li $t0, 13
	li $t1, 4
	divu $t0, $t1
	mflo $a0
	li $v0, 1
	syscall
	
	# 打印字符串2
	la $a0, str2
	li $v0, 4
	syscall
	
	# 输出余数
	mfhi $a0
	li $v0, 1
	syscall
	
	li $v0, 10
	syscall
	
	
	