.data #数据段
	str: .asciiz "A" # 占据两个字节， A 的 ASCII 码值 A：65 + ‘\0': 0
	d1: .word 10 # 仅仅是初始值
	arrayx: .space 10 # 申请10个字节 byte， 没有进行初始化
	
.text #指令段
	la $a0, str  # load address
	li $v0, 4 # loqe immediate
	syscall
	
	lb $t0, ($a0) # load byte from memory 
	addi $t0, $t0, 32   # add immediate
	sb $t0, str # store byte -> memory
	syscall