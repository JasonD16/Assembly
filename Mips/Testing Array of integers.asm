.data
	MyArray: .space 20
	space: .asciiz " "
	finished: .asciiz "\nFinished successfully"
.text
main:
	li $t0, 0 #array index starts at 0
	li $t2, 20 #beq condition set
	li $t1, 0		#value inside the array (should be 1-2-3-4-5 at the end)
loop:
#{
	beq $t0, $t2, print 	# if(t0 == t2) so if(index == 20) so a total of 5 elements from 0 to 16 (integers so we multiply by 4 then exit the loop
	sw $t1, MyArray($t0)
	addi $t1, $t1, 4
	addi $t0, $t0, 4
	j loop
#}

next: 
#{	
	li $v0, 4
	la $a0, finished
	syscall
	
	li $v0, 10
	syscall
#}	

print:
#{

	li $t0, 0	#index of the array
	li $t2, 20	#Array size
PrintLoop:
	beq $t0, $t2, next	#Condition
	lw $t1, MyArray($t0)
	
	#Printing the integers
	li $v0, 1
	addi $a0, $t1, 0
	syscall
	
	li $v0, 4
	la $a0, space
	syscall
	
	addi $t0, $t0, 4
	j PrintLoop
#}