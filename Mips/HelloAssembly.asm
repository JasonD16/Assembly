.data
		num1: .word 5
		num2: .word 11
.text
		lw $t0, num1($zero)
		lw $t1, num2($zero)
	
		add $t2, $t0, $t1	# t2 = t0 + t1
	
		li $v0, 1		# 1 for integers
		add $a0, $zero, $t2	# a0 = t2, we moved the value from t2 to a0
		syscall	
