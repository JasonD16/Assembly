.data
	name: .asciiz "Edwardo"
.text
	li $v0, 4
	la $a0, name
	syscall