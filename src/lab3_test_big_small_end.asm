.include "print_string.asm"
.data
	tdata0: .byte 0x11, 0x22, 0x33, 0x44
	tdata: .word 0x44332211
	tdata1: .word 0x00112233, 0x44556677
.text
main:
	lh $a0, tdata # С�˻��� �ҵ�ַ���մ�С����洢 �����ȶ�ȡС��ַ�Ĳ���
	li $v0, 34
	syscall
	
	lh $a0,  tdata
	li $v0, 34
	syscall
	print_string("\n")
	la $t0,tdata1
	lb $a0,($t0)
	li $v0,34
	syscall
	lb $a0,1($t0)
	syscall
	lb $a0,2($t0)
	syscall
	lb $a0,3($t0)
	syscall
	lw $a0,4($t0)
	syscall
	end
	
	
	
	
	
	
	
	
	
	
	
	
	
	