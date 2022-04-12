.macro divSCheck(%f1, %f2, %f3)
	.data 
		zero: .float 0.0
		eleven: .float 11.0
	.text	
		l.s $f1, eleven
		l.s $f2 zero
		c.eq.s  %f3, $f2
		bc1f OK
		addi $k0, $zero, 11
		break
	
	OK:	
		div.s %f1, %f2, %f3	
.end_macro 

.text
	li $v0,6
	syscall
	mov.s $f20,$f0
	li $v0,6
	syscall
	mov.s $f21,$f0
	divSCheck($f12,$f20,$f21)
	li $v0,2
	syscall
	li $v0,10
	syscall
	
	
.ktext 0x80000180
	addi $sp, $sp, -8
	sw $v0, 0($sp)
	sw $a0, 4($sp)
	
	bne $k0, 11, out
	la $a0,msg
	li $v0,4
	syscall
out:	
	lw $a0, 4($sp)
	lw $v0, 0($sp)
	
	mfc0 $k0,$14
	addi $k0,$k0,4
	mtc0 $k0,$14
	
	addi $sp, $sp, 8
	eret
.kdata
	msg: .asciiz  "exception:divisor is 0.0 "

		
		