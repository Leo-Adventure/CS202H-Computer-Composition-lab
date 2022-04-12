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
	chars: .space 12
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
	
	add $t1, $zero, $zero # t1 存储 cnt ,初始化为 0
	add $t2, $t2, $t0 #  t2 存储 bit_num
	la $t3, nums # t3 存储 nums 地址
	j TEST1 # jump to middle
LOOP1:
	sll $t5, $t1, 2 # t5 = cnt * 4
	add $t5, $t3, $t5 # t5 代表当前数组地址
	div $t2, $t2, 2 # bit_num / 2
	mflo $t2 # t2 存储商
	mfhi $t6 # t6 存储余数
	sw $t6, 0($t5)	# 由于余数非0即1，直接把余数放入数组当中
	addi $t1, $t1, 1 # cnt++
	
TEST1:
       	
	bne $t2, $zero, LOOP1 # 假如 bit_num != 0 , $t4 = 1, 进入while循环
	
	print_string("Its binary is : 0b")
	j TEST2 # jump to middle
LOOP2:
	sll $t5, $t1, 2 # t5 = cnt * 4
	addi $t5, $t5, -4 # 地址减去一个字节
	add $t5, $t3, $t5 # t5 代表当前数组地址
	li $v0, 1 # print integer
	lw $a0, 0($t5)
	syscall
	addi $t1, $t1, -1

TEST2:
	sne $t4, $t1, $zero # cnt ！= 0，$t4 = 1, 进入while 循环
	bne $t4, $zero, LOOP2
	
	
hex:	# 显示十六进制形式
	
	add $t1, $zero, $zero # t1 存储 cnt2 ,初始化为 0
	add $t2, $t2, $t0 #  t2 存储 hex_num
	la $t3, nums # t3 存储 chars 地址
	j TEST3 # jump to middle
LOOP3:
	sll $t5, $t1, 2
	add $t5, $t3, $t5 # t5 代表当前数组地址
	div $t2, $t2, 16 # hex_num / 16
	mflo $t2 # t2 存储商
	mfhi $t6 # t6 存储余数
H0:	
	bne $t6, 0, H1 # 如果是余数$t6是0，就将“0”存在当前数组的地址 $t5 上面
	la $s1, h0
	sw $s1, 0($t5)
	j fin
H1:
	bne $t6, 1, H2
	la $s1, h1
	sw $s1, 0($t5)
	j fin
H2: 
	bne $t6, 2, H3
	la $s1, h2
	sw $s1, 0($t5)
	j fin
H3:
	bne $t6, 3, H4
	la $s1, h3
	sw $s1, 0($t5)
	j fin
H4:	
	bne $t6, 4, H5
	la $s1, h4
	sw $s1, 0($t5)
	j fin	
H5: 
	bne $t6, 5, H6
	la $s1, h5
	sw $s1, 0($t5)
	j fin
H6:
	bne $t6, 6, H7
	la $s1, h6
	sw $s1, 0($t5)
	j fin
H7:
        bne $t6, 7, H8
	la $s1, h7
	sw $s1, 0($t5)
	j fin
H8:
	bne $t6, 8, H9
	la $s1, h8
	sw $s1, 0($t5)
	j fin
	
H9:
	bne $t6, 9, H10
	la $s1, h9
	sw $s1, 0($t5)	
	j fin
	
H10:
	bne $t6, 10, H11
	la $s1, h10
	sw $s1, 0($t5)
	j fin
H11:
	bne $t6, 11, H12
	la $s1, h11
	sw $s1, 0($t5)
	j fin
H12:
	bne $t6, 12, H13
	la $s1, h12
	sw $s1, 0($t5)
	j fin	
H13:
	bne $t6, 13, H14
	la $s1, h13
	sw $s1, 0($t5)
	j fin
H14:
	bne $t6, 14, H15
	la $s1, h14
	sw $s1, 0($t5)
	j fin	
H15:
	bne $t6, 15, fin
	la $s1, h15
	sw $s1, 0($t5)
	
fin:
	addi $t1, $t1, 1 # cnt++
	
TEST3:
       	
	bne $t2, $zero, LOOP3 # 假如 bit_num != 0 , $t4 = 1, 进入while循环
	

	print_string(", its hexadecimal is : 0x")
	j TEST4 # jump to middle
LOOP4:
	sll $t5, $t1, 2
	addi $t5, $t5, -4 # 地址减去一个字节
	add $t5, $t3, $t5 # t5 代表当前数组地址
	li $v0, 4 # print integer
	lw $a0, 0($t5)
	syscall
	addi $t1, $t1, -1
	
TEST4:
	sne $t4, $t1, $zero # cnt2 ！= 0，$t4 = 1, 进入while 循环
	bne $t4, $zero, LOOP4
	
	print_string("\n")
	end