.macro print(%str)
li $v0, 4
la $a0, %str
syscall
.end_macro 

.macro end
	li $v0,10
	syscall
.end_macro

.data 
	hex: .asciiz "0123456789abcdef"
	invalid: .asciiz  "invalid input" 
	s_str: .asciiz "s: "
	e_str: .asciiz  ", e: 0x"
	f_str: .asciiz  ", f: 0x"
	value_str: .asciiz  ", value: "
	line_str: .asciiz "\n"
	str: .space 20
.text
	# 输入一个字符串
	li $v0, 8
	#设置两个参数
	la $a0, str 
	la $t0, hex
	li $a1, 20
	syscall
	
	la $t1, ($a0) # t1 存储地址初地址
	addi $t2, ,$zero, 0 # res
	addi $t3, ,$zero, 0
	add $s0, $t1, $t3 # $s0 存储数组地址
	lb $t4, 0($s0)
	j judge
loop:
	add $s0, $t1, $t3 # $s0 存储数组地址
	lb $t4, 0($s0) # t4 = str[cnt]
	beq $t4, 10, stop
	bne $t3, 0, out1
	beq $t4, 48, out1
	print(invalid)
	end
out1:	
	bne $t3, 1, out2
	beq $t4, 88, out2
	beq $t4, 120, out2
	print(invalid)
	end

out2:
	blt $t3, 2, out3
	add $t5, $zero, $zero # num = 0
	blt $t4, 48, out2out1
	bgt $t4, 57, out2out1
	sub $t5, $t4, 48
	j out2out4
	
out2out1:
	blt $t4, 97, out2out2
	bgt $t4, 102, out2out2
	sub $t5, $t4, 97
	addi $t5, $t5, 10
	j out2out4

out2out2:
	blt $t4, 65, out2out3
	bgt $t4, 70, out2out3
	sub $t5, $t4, 65
	addi $t5, $t5, 10
	j out2out4

out2out3:
	print(invalid)
	end
out2out4:
	sll $t2, $t2, 4
	or $t2, $t2, $t5
out3:
	addi $t3, $t3, 1
	
judge:
	beq $t4, 10, stop
	bgt, $t3, 10, stop
	j loop
stop:
	ble $t3, 2, print_invalid
	bgt $t3, 11, print_invalid
	j outside
print_invalid:
	print(invalid)
	end
outside:
	add $t5, $zero, $t2 # 备份
	andi $s1, $t2, 8388607 # frac
	srl $t2, $t2, 23
	andi $s2, $t2, 255 # exp
	srl $t2, $t2, 8
	andi $t2, $t2, 1
	
	print(s_str)
	add $a0, $zero, $t2
	li $v0, 1
	syscall
	print(e_str)
	andi $s3, $s2, 15 # low_bit
	srl $s2, $s2, 4
	andi $s4, $s2, 15 # high_bit
	
	add $s3, $t0, $s3
	add $s4, $t0, $s4
	
	lb $s3, 0($s3)
	lb $s4, 0($s4)
	
	li $v0, 11
	add $a0, $zero, $s4
	syscall
	add $a0, $zero, $s3
	syscall
	print(f_str)
	
	
	andi $a1, $s1, 15
	add $a1, $t0, $a1
	lb $a1, ($a1)
	srl $s1, $s1, 4
	
	andi $a2, $s1, 15
	add $a2, $t0, $a2
	lb $a2, ($a2)
	srl $s1, $s1, 4
	
	andi $a3, $s1, 15
	add $a3, $t0, $a3
	lb $a3, ($a3)
	srl $s1, $s1, 4
	
	andi $s5, $s1, 15
	add $s5, $t0, $s5
	lb $s5, ($s5)
	srl $s1, $s1, 4
	
	andi $s6, $s1, 15
	add $s6, $t0, $s6
	lb $s6, ($s6)
	srl $s1, $s1, 4
	
	andi $s7, $s1, 15
	add $s7, $t0, $s7
	lb $s7, ($s7)
	
	li $v0, 11
	add $a0, $zero, $s7
	syscall
	add $a0, $zero, $s6
	syscall
	add $a0, $zero, $s5
	syscall	
	add $a0, $zero, $a3
	syscall
	add $a0, $zero, $a2
	syscall
	add $a0, $zero, $a1
	syscall
	print(value_str)
	
	
	mtc1 $t5, $f12
	li $v0, 2
	syscall
	# print(line_str)
	end
	
	
	
	
	
	
	
	
	
	
	
		
	
	
	
	
	
	