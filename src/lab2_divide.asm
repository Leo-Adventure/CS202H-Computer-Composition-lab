.data
	str1: .asciiz "13/4 quotient is : "
	str2: .asciiz " , remander is : "
.text
main:
	# ��ӡ�ַ���
	la $a0, str1
	li $v0, 4
	syscall
	
	# �������̱�����lo������������hi
	# ֮���ӡ�ַ���
	li $t0, 13
	li $t1, 4
	divu $t0, $t1
	mflo $a0
	li $v0, 1
	syscall
	
	# ��ӡ�ַ���2
	la $a0, str2
	li $v0, 4
	syscall
	
	# �������
	mfhi $a0
	li $v0, 1
	syscall
	
	li $v0, 10
	syscall
	
	
	