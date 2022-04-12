.data 
	d1: .double 1.0
	d0: .double 0.0
	fun_cnt: .double 1.0
	
	cnt: .double 1.0
	sum: .double 1.0
	pc: .double 1.0

	
.text
	li $v0, 7 # 读取待比较的精度
	syscall
	mov.d $f6, $f0 # 需要比较的精度存储在 $f6 当中
	l.d $f4, cnt # $f4初始值为1，存储传入函数的值
	l.d $f14, cnt # 记录当次循环中 $f4 的值
	l.d $f8, sum # $f8 初始值为1, 存储最终计算结果
	l.d $f10 pc # 每次加1
loop_main:
	mov.d $f14, $f4
	jal fac
	c.lt.d $f0, $f6
	bc1t outside
	mov.d $f4, $f14
	add.d $f4, $f4, $f10
	add.d $f8, $f8, $f0
	j loop_main
outside:
	mov.d $f12, $f8
	li $v0, 3
	syscall
	li $v0, 10
	syscall
	

fac: # 传进来的参数是 $f4 -- num, 初始值1， 结果 sum 放在 $f0 当中
	# addi $sp, $sp, -8 # save the initial value
	# s.d $f2, 0($sp)
	
	l.d $f0, d1 # sum = 1
	l.d $f2, d0 # 用来比较的值0
	l.d $f16, fun_cnt # 设定函数内部计数器
	# f4 是传进来的 num
	j judge
	
Loop:
	mul.d $f0, $f0, $f4
	sub.d $f4, $f4, $f16
	
judge:
	c.eq.d $f4, $f2 # 看num ?= 0
	bc1f Loop
	div.d $f0, $f16, $f0
	
	# l.d $f2, 0($sp)
	# addi $sp, $sp, 8
	jr $ra
	
	
	