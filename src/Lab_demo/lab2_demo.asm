.data #���ݶ�
	str: .asciiz "A" # ռ�������ֽڣ� A �� ASCII ��ֵ A��65 + ��\0': 0
	d1: .word 10 # �����ǳ�ʼֵ
	arrayx: .space 10 # ����10���ֽ� byte�� û�н��г�ʼ��
	
.text #ָ���
	la $a0, str  # load address
	li $v0, 4 # loqe immediate
	syscall
	
	lb $t0, ($a0) # load byte from memory 
	addi $t0, $t0, 32   # add immediate
	sb $t0, str # store byte -> memory
	syscall