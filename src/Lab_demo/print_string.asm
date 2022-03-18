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