.data
Chosen: .word -1, -1, -1, -1, -1, -1, -1, -1
space: .asciiz " - "

.text
.globl main

main:
    li $t0, 8
    la $s0, Chosen
loop:
    beq $t0, 0, end
    # New line
    li $v0, 4
    la $a0, space
    syscall
    # Generate random number
    li $a1, 32  # 0 to 31
    li $v0, 42  # Built-in random function
    syscall
    # Call the Check function
    jal Check
    beqz $v0, loop  # If the number is not unique, retry
    # Print the unique number
    li $v0, 1
    syscall
    # New line
    li $v0, 4
    la $a0, space
    syscall
    # Store the unique number in the array
    sw $a1, 0($s0)
    addi $s0, $s0, 4
    addi $t0, $t0, -1
    j loop

Check:
    la $s0, Chosen
    li $t1, 8
loop1:
    beq $t1, 0, unique  # If we've checked all elements and found no match, it's unique
    lw $t2, 0($s0)
    beq $a0, $t2, not_unique  # If a match is found, it's not unique
    addi $s0, $s0, 4
    addi $t1, $t1, -1
    j loop1

unique:
    li $v0, 1  # Set return value to 1 (unique)
    jr $ra

not_unique:
    li $v0, 0  # Set return value to 0 (not unique)
    jr $ra

end:
    li $v0, 10
    syscall