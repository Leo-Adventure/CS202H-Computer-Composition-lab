.macro print_string(%str)
	.data 
		pstr: .asciiz   %str       #pstr: .asciiz "\n"  vs  pstr: .asciiz \n (not ok)
	.text
		la $a0,pstr
		li $v0,4
		syscall
.end_macro

.macro end
	li $v0,10
	syscall
.end_macro

.data
	nums: .space 132
	chars: .space 120
	h0: .asciiz "0"
	h1: .asciiz "1"
	h2: .asciiz "2"
	h3: .asciiz "3"
	h4: .asciiz "4"
	h5: .asciiz "5"
	h6: .asciiz "6"
	h7: .asciiz "7"
	h8: .asciiz "8"
	h9: .asciiz "9"
	h10: .asciiz "a"
	h11: .asciiz "b"
	h12: .asciiz "c"
	h13: .asciiz "d"
	h14: .asciiz "e"
	h15: .asciiz "f"

.text
main:
	li $v0, 5
	syscall
	move $t0, $v0 # t0 存储 num
	li $v0, 1
	move $a0, $t0
	syscall
	
	add $t1, $zero, $zero # t1 存储 cnt ,初始化为 0
	add $t2, $t2, $t0 #  t2 存储 bit_num
	la $t3, nums # t3 存储 nums 地址
	j CAL_TEST1 # jump to middle
CAL_LOOP1:
	sll $t5, $t1, 2 # t5 = cnt * 4
	add $t5, $t3, $t5 # t5 代表当前数组地址
	div $t2, $t2, 2 # bit_num / 2
	mflo $t2 # t2 存储商
	mfhi $t6 # t6 存储余数
	sw $t6, 0($t5)	# 由于余数非0即1，直接把余数放入数组当中
	addi $t1, $t1, 1 # cnt++
	
	
CAL_TEST1:
       	
	bne $t2, $zero, CAL_LOOP1 # 假如 bit_num != 0 , $t4 = 1, 进入while循环


hex:	# 显示十六进制形式
	
	add $s0, $zero, $zero # s0 存储 cnt2 ,初始化为 0
	add $s2, $s2, $t0 #  s2 存储 hex_num
	la $s3, chars # s3 存储 chars 地址
	j CAL_TEST2 # jump to middle
CAL_LOOP2:
	sll $s5, $s0, 2
	add $s5, $s3, $s5 # s5 代表当前数组地址
	div $s2, $s2, 16 # hex_num / 16
	mflo $s2 # s2 存储商
	mfhi $s6 # s6 存储余数
H0:	
	bne $s6, 0, H1 # 如果是余数$s6是0，就将“0”存在当前数组的地址 $s5 上面
	la $s1, h0
	sw $s1, 0($s5)
	j fin
H1:
	bne $s6, 1, H2
	la $s1, h1
	sw $s1, 0($s5)
	j fin
H2: 
	bne $s6, 2, H3
	la $s1, h2
	sw $s1, 0($s5)
	j fin
H3:
	bne $s6, 3, H4
	la $s1, h3
	sw $s1, 0($s5)
	j fin
H4:	
	bne $s6, 4, H5
	la $s1, h4
	sw $s1, 0($s5)
	j fin	
H5: 
	bne $s6, 5, H6
	la $s1, h5
	sw $s1, 0($s5)
	j fin
H6:
	bne $s6, 6, H7
	la $s1, h6
	sw $s1, 0($s5)
	j fin
H7:
        bne $s6, 7, H8
	la $s1, h7
	sw $s1, 0($s5)
	j fin
H8:
	bne $s6, 8, H9
	la $s1, h8
	sw $s1, 0($s5)
	j fin
	
H9:
	bne $s6, 9, H10
	la $s1, h9
	sw $s1, 0($s5)	
	j fin
	
H10:
	bne $s6, 10, H11
	la $s1, h10
	sw $s1, 0($s5)
	j fin
H11:
	bne $s6, 11, H12
	la $s1, h11
	sw $s1, 0($s5)
	j fin
H12:
	bne $s6, 12, H13
	la $s1, h12
	sw $s1, 0($s5)
	j fin	
H13:
	bne $s6, 13, H14
	la $s1, h13
	sw $s1, 0($s5)
	j fin
H14:
	bne $s6, 14, H15
	la $s1, h14
	sw $s1, 0($s5)
	j fin	
H15:
	bne $s6, 15, fin
	la $s1, h15
	sw $s1, 0($s5)
	
fin:
	addi $s0, $s0, 1 # cnt++
	
CAL_TEST2:
	bne $s2, $zero, CAL_LOOP2 # 假如 bit_num != 0 , $t4 = 1, 进入while循环
	
Judge:
	add $t8, $zero, $zero # i = 0
	add $k0, $zero, $zero # flag = false
	j test1
loop1:
	
	sll $a1, $t8, 2 # t8 是 i
	add $a1, $a1, $t3
	lw $a2, 0($a1) # nums[i]
	sub $t9, $t1, $t8 # cnt - i
	subi $t9, $t9, 1 # cnt - i - 1
	sll $t9, $t9, 2
	add $t9, $t9, $t3
	lw $a3, 0($t9) # nums[cnt - i - 1]
	beq $a2, $a3, jump
	add $k0, $zero, 1 # 只要有不相等的就设置 t9 = 1
jump:
	addi $t8, $t8, 1	
test1:	
	bne $t8, $t1, loop1
	
	beq $k0, 1, print_not1
	print_string(" is binary palindrome, ")
	j Judge2
print_not1:
	print_string(" is NOT binary palindrome, ")
	
Judge2:	
	add $t8, $zero, $zero # i = 0
	add $k1, $zero, $zero # flag = false
	j test2
loop2:
	
	sll $a1, $t8, 2
	add $a1, $a1, $s3
	lw $a2, 0($a1) # chars[i]
	sub $t9, $s0, $t8 # cnt2 - i
	subi $t9, $t9, 1 # cnt2 - i - 1
	sll $t9, $t9, 2
	add $t9, $t9, $s3
	lw $a3, 0($t9) # chars[cnt - i - 1]
	beq $a2, $a3, jump2
	add $k1, $zero, 1 # 只要有不相等的就设置 t9 = 1
	
jump2:
	addi $t8, $t8, 1	
test2:	
	bne $t8, $s0, loop2 # 只要 i != cnt 进入循环
	
	
	li $v0, 1
	add $a0, $zero, $t0
	syscall 
	
	beq $k1, 1, print_not2
	print_string(" is hexadecimal palindrome\n")
	j end1
print_not2:
	print_string(" is NOT hexadecimal palindrome\n")
end1:
	


finally:
	add $t7, $t1, $zero # t7 备份 cnt 为了后续的正序输出数组
	
PRINT1:
	print_string("x2: 0b")
	j PRINT_TEST1 # jump to middle
PRINT_LOOP1:
	sll $t5, $t1, 2 # t5 = cnt * 4
	addi $t5, $t5, -4 # 地址减去一个字节
	add $t5, $t3, $t5 # t5 代表当前数组地址
	li $v0, 1 # print integer
	lw $a0, 0($t5)
	syscall
	addi $t1, $t1, -1

PRINT_TEST1:
	sne $t4, $t1, $zero # cnt ！= 0，$t4 = 1, 进入while 循环
	bne $t4, $zero, PRINT_LOOP1
	

PRINT2:
	print_string("\nx2r: 0b")
	add $t1, $zero, $zero # 将 t1 置零
	j PRINT_TEST2
PRINT_LOOP2:
	sll $t5, $t1, 2
	add $t5, $t5, $t3 # 寻找到当前数组的位置
	lw $a0, 0($t5)
	li $v0, 1
	syscall
	addi $t1, $t1, 1 # cnt ++

PRINT_TEST2:
	bne $t1, $t7, PRINT_LOOP2
		
	
	add $s7, $s0, $zero # 备份 cnt2
	print_string("\nx16: 0x")
	j PRINT_TEST3 # jump to middle
PRINT_LOOP3:
	sll $s5, $s0, 2
	addi $s5, $s5, -4 # 地址减去一个字节
	add $s5, $s3, $s5 # t5 代表当前数组地址
	li $v0, 4 # print string
	lw $a0, 0($s5)
	syscall
	addi $s0, $s0, -1
	
PRINT_TEST3:
	sne $s4, $s0, $zero # cnt2 ！= 0，$t4 = 1, 进入while 循环
	bne $s4, $zero, PRINT_LOOP3
	
	print_string("\nx16r: 0x")
	add $s0, $zero, $zero # 将 t1 置零
	
	j PRINT_TEST4
	
PRINT_LOOP4:
	sll $s5, $s0, 2
	add $s5, $s5, $s3
	lw $a0, 0($s5)
	li $v0, 4
	syscall
	addi $s0, $s0, 1
	
PRINT_TEST4:
	bne $s0, $s7, PRINT_LOOP4
	
	print_string("\n")
	end 



