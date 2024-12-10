.data
	Diameter: .asciiz "Enter diameter: "
	Area: .asciiz "\nArea is: "
	
	Pi: .float 3.14159
	Const2: .float 2.0
.text
main:
	li $v0,4
	la $a0, Diameter
	syscall
	
	li $v0, 6 #taking diameter as float
	syscall
	mov.s $f1, $f0 #move the user input from default f0 to f1
	
	li $v0, 4
	la $a0, Area
	syscall
	
	lwc1 $f2, Pi
	lwc1 $f3, Const2
	
	div.s $f1, $f1, $f3 #divide diameter by 2
	mul.s $f1, $f1, $f1 #multiply rayon * rayon so f1 = r^2 
	mul.s $f12, $f2, $f1
	
	li $v0, 2
	syscall
	
	li $v0,10
	syscall