Load_Score_Sound:
addi $sp $sp -4
sw $ra 0($sp)
#scoreboard sound
li $v0 31
li $a0 101 
li $a1 850
li $a2 2
li $a3 85
syscall

lw $ra ($sp)
addi $sp $sp 4







Load_End_Sound:
addi $sp $sp -4
sw $ra 0($sp)
#card flipping sound
li $v0 31
li $a0 10
li $a1 4000
li $a2 2
li $a3 120
syscall

lw $ra ($sp)
addi $sp $sp 4