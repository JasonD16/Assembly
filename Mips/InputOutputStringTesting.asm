.data
	Input: .asciiz "Enter a word: "
	output: .asciiz "\nWord is: "
	User_Input: .space 20

.text

	li $v0,4
	la $a0, Input
	syscall 
	
	li $v0, 8
	la $a0, User_Input
	li $a1, 20
	syscall
	
	li $v0,4
	la $a0, output
	syscall 
	
	li $v0, 4
	la $a0, User_Input
	syscall
	
	li $v0, 10
	syscall