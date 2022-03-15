.include "print_string.asm"
.data
	tdata: .byte 0x0F00F08F
.text
main:
	lb $a0, tdata
	li $v0, 1
	syscall
	
	print_string("\n")
	lb $a0, tdata
	li $v0, 36
	syscall
	
	end