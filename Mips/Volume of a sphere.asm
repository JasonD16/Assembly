.data
	radius: .asciiz "Enter radius: "
	volume_result: .asciiz "\nVolume = "
	pi: .float 3.14
	const3: .float 3.0
	const4: .float 4.0
.text

main:
	#Cout << "enter radius"
	li $v0, 4
	la $a0, radius
	syscall
	
	#cin >> f1
	li $v0, 6
	syscall
	mov.s $f1, $f0
	
	#cout << "Volume ="
	li $v0, 4
	la $a0, volume_result
	syscall
	
	lwc1 $f3, const3 #f2 = 3
	lwc1 $f4, const4 #f3 = 4
	div.s $f2, $f4, $f3 # 4/3
	
	mul.s $f5, $f1, $f1 #f1 = r * r = r^2
	mul.s $f1, $f1, $f5 #f1 = r^2 * r = r^3
	
	lwc1 $f4, pi #$f4 = pi = 3.14
	mul.s $f1, $f1, $f4 #$f1 = r^3 * 3.14
	mul.s $f12, $f1, $f2 #$f12 = $f1 * $f2 = 3.14 * r ^ 3 * 4/3
	
	li $v0, 2
	syscall
	
	li $v0, 10
	syscall