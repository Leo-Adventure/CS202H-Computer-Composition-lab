.data 
	d1: .double 1.0
	d0: .double 0.0
	fun_cnt: .double 1.0
	
	cnt: .double 1.0
	sum: .double 1.0
	pc: .double 1.0

	
.text
	li $v0, 7 # ��ȡ���Ƚϵľ���
	syscall
	mov.d $f6, $f0 # ��Ҫ�Ƚϵľ��ȴ洢�� $f6 ����
	l.d $f4, cnt # $f4��ʼֵΪ1���洢���뺯����ֵ
	l.d $f14, cnt # ��¼����ѭ���� $f4 ��ֵ
	l.d $f8, sum # $f8 ��ʼֵΪ1, �洢���ռ�����
	l.d $f10 pc # ÿ�μ�1
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
	

fac: # �������Ĳ����� $f4 -- num, ��ʼֵ1�� ��� sum ���� $f0 ����
	# addi $sp, $sp, -8 # save the initial value
	# s.d $f2, 0($sp)
	
	l.d $f0, d1 # sum = 1
	l.d $f2, d0 # �����Ƚϵ�ֵ0
	l.d $f16, fun_cnt # �趨�����ڲ�������
	# f4 �Ǵ������� num
	j judge
	
Loop:
	mul.d $f0, $f0, $f4
	sub.d $f4, $f4, $f16
	
judge:
	c.eq.d $f4, $f2 # ��num ?= 0
	bc1f Loop
	div.d $f0, $f16, $f0
	
	# l.d $f2, 0($sp)
	# addi $sp, $sp, 8
	jr $ra
	
	
	