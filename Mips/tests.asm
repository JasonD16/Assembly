.data
	base: .asciiz "Enter base:"
	height: .asciiz "\nEnter Height:"
	result: .asciiz "\nResult is:"
	
	const2: .double 2.00
.text
main:
	#Ask user to input base
	li $v0, 4
	la $a0, base
	syscall
	
	#Take user input and put it in $f0
	li $v0, 7
	syscall
	mov.d $f2, $f0
	
	#Ask user to input height
	li $v0, 4
	la $a0, height
	syscall
	
	#Take user input and put it in $f1
	li $v0, 7
	syscall
	mov.d $f4, $f0
	
	#Output the result
	li $v0, 4
	la $a0, result
	syscall
	
	mul.d $f0, $f2, $f4
	l.d $f2, const2 #load 2.0
	div.d $f12, $f0, $f2
	
	li $v0, 3
	syscall
	
	li $v0, 10
	syscall
	