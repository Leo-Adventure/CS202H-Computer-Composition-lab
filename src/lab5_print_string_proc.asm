.text
print_string:
	addi $sp, $sp, -4
	sw $v0, ($sp)
	
	li $v0, 4
	syscall
	
	lw $v0, ($sp)
	addi $sp, $sp, 4
	
	jr $ra
	