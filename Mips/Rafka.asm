.data
displayAddress: .word 0x10008000
penguin1: .word 0x10007F9C
egg1: .word 0x1000871C
penguin2: .word 0x1000805C
egg2: .word 0x1000875C
ub1: .word 0x10008114    # Upper bound for Egg 1
ub2: .word 0x10008158    # Upper bound for Egg 2
brickToUL:	.word 0x100089A0 
beep: 		.byte 72
duration: 	.byte 100
volume:		.byte 127
floor:     .word 0x10008800  # Address of the floor
promptP1:  .asciiz "Player 1, press w to move Egg 1:\n"
promptP2:  .asciiz "Player 2, press o to move Egg 2:\n"
egg1Wins:  .asciiz "Egg 1 wins!\n"
egg2Wins:  .asciiz "Egg 2 wins!\n"

.text
main:

#paint background
	lw $t0, displayAddress # load base address
	lw $s5, penguin1 # load car1 address
	lw $s6, penguin2 # load car2 address
	lw $s7, egg2
	lw $s4, egg1	

	li $t1, 2048 # the screen size is 2048
	li $t2, 0x00F9F9F9 # load color black	
	
setBackground:
	
	sw $t2, 0($t0) #paint black on background
	addi $t0, $t0, 4
	addi $t1, $t1, -1
	bnez $t1, setBackground

#paint two yellow line in the middle
	lw $t0, displayAddress
	li $t1, 64 # the length is 64
	li $t2, 0x00FFFF00 # load color yellow
setCentreline:
	sw $t2, 60($t0)	# 64 is the centre, so we draw line on 60 and 68
	sw $t2, 68($t0)
	addi $t0, $t0, 128 #go to new line
	addi $t1, $t1, -1
	bnez $t1, setCentreline

#paint two dot white linw
	lw $t0, displayAddress
	li $t1, 64 #the length is 64
li $t2, 0x00FFFFFF # load color white	

setWhiteline: 

	sw $t2, 28($t0) #line on the right lane
	sw $t2, 96($t0) #line on right lane
	addi $t0, $t0, 128
	
	addi $t1, $t1, -1
	bne $t1, 0, setWhiteline	

		
	lw $t0, displayAddress
	li $t1, 64 # the width is 32 so 2 lines is 64
	li $t2, 0x7CFC00 # load color green
	
drawegg1:
        li $t1,0xFF00FF00
        sw $t1,8($s7)
        
drawegg2:
li $t1, 0xFFFF0000
sw $t1, 0($s4)

drawpenguin1:	
        li $t1, 0xFF000000  # load black 
	li $t2, 0xecca00 # load yellow
        add $s5,$s5,128
        sw $t1, -4($s5)
	sw $t1, 0($s5)
	sw $t1, 4($s5)
	add $s5,$s5,128
	sw $t1, -8($s5)
	sw $t1, -4($s5)
	sw $t1,0($s5)
	sw $t1, 4($s5)
	sw $t1, 8($s5)
	add $s5,$s5,128
	sw $t1, -12($s5)
	sw $t1, -8($s5)
	sw $t1, 8($s5)
	sw $t1, 12($s5)
	add $s5,$s5,128
	sw $t1, -12($s5)
	sw $t1, -4($s5)
	sw $t1, 4($s5)
	sw $t1, 12($s5)
	add $s5,$s5,128
	sw $t1, -12($s5)
	sw $t1,-4($s5)
	sw $t1, 4($s5)
	sw $t1, 12($s5)
	add $s5,$s5,128
	sw $t1, -16($s5)
	sw $t1, -12($s5)
	sw $t2, 0($s5)
	sw $t1, 12($s5)
	sw $t1, 16($s5)
	add $s5,$s5,128
	sw $t1, -20($s5)
	sw $t1, -16($s5)
	sw $t1, 16($s5)
	sw $t1, 20($s5)
	add $s5,$s5,128
	sw $t1, -20($s5)
	sw $t1, -16($s5)
	sw $t1, 16($s5)
	sw $t1, 20($s5)
	add $s5,$s5,128
	sw $t1, -16($s5)
	sw $t1, -12($s5)
	sw $t1, 12($s5)
	sw $t1, 16($s5)
	add $s5,$s5,128
	sw $t1, -12($s5)
	sw $t1, 12($s5)
	add $s5,$s5,128
	sw $t2, -8($s5)
	sw $t2, -4($s5)
	sw $t1, 0($s5)
	sw $t2, 4($s5)
	sw $t2, 8($s5)
	


drawpenguin2:
        li $t1, 0xFF000000  # load black 
	li $t2, 0xecca00 # load yellow 
	

	sw $t1, 4($s6)
	sw $t1, 8($s6)
        sw $t1, 12($s6)
	add $s6,$s6,128
	sw $t1, 0($s6)
	sw $t1,4($s6)
	sw $t1,8($s6)
        sw $t1,12 ($s6)
	sw $t1,16($s6)
	add $s6,$s6,128
	sw $t1,-4($s6)
	sw $t1,0($s6)
	sw $t1,16($s6)
	sw $t1,20($s6)
	add $s6,$s6,128
	sw $t1,-4($s6)
	sw $t1,4($s6)
	sw $t1,12($s6)
	sw $t1,20($s6)
	add $s6,$s6,128
	sw $t1,-4($s6)
	sw $t1,4($s6)
	sw $t1,12($s6)
	sw $t1,20($s6)
	add $s6,$s6,128
	sw $t1,-8($s6)
	sw $t1,-4($s6)
	sw $t2,8($s6)
	sw $t1,20($s6)
	sw $t1,24($s6)
	add $s6,$s6,128
	sw $t1,-12($s6)
	sw $t1,-8($s6)
	sw $t1,24($s6)
	sw $t1,28($s6)
	add $s6,$s6,128
	sw $t1,-12($s6)
	sw $t1,-8($s6)
	sw $t1,24($s6)
	sw $t1,28($s6)
	add $s6,$s6,128
	sw $t1,-8($s6)
	sw $t1,-4($s6)
	sw $t1,20($s6)
	sw $t1,24($s6)
	add $s6,$s6,128
	sw $t1,20($s6)
	sw $t1,-4($s6)
	add $s6,$s6,128
	sw $t2,0($s6)
	sw $t2,4($s6)
	sw $t1,8($s6)
	sw $t2,12($s6)
	sw $t2,16($s6)

 jal game_loop

game_loop:
    # Display prompt for Player 1
    la $a0, promptP1
    li $v0, 4             # Print string syscall
    syscall

    # Get input for Player 1
    li $v0, 12            # Read character syscall
    syscall
    beq $v0, 119, move_egg1  # 'w' moves Egg 1

    # Display prompt for Player 2
    la $a0, promptP2
    li $v0, 4             # Print string syscall
    syscall

    # Get input for Player 2
    li $v0, 12            # Read character syscall
    syscall
    beq $v0, 111, move_egg2  # 'o' moves Egg 2

    j game_loop           # Loop back to wait for inputs

# Move Egg 1
move_egg1:
    lw $t0, egg1          # Load Egg 1 position
    li $t1, 0xFFFFFF      # White (background color) to clear old position
    sw $t1, 0($t0)        # Clear old position

    addi $t0, $t0, 128   # Move up one line
    li $t1, 0x00FF0000    # Red (Egg 1 color)
    sw $t1, 0($t0)        # Draw at new position

    sw $t0, egg1          # Update Egg 1 position in memory
    jr $ra

# Move Egg 2
move_egg2:
    lw $t0, egg2          # Load Egg 2 position
    li $t1, 0xFFFFFF      # White (background color) to clear old position
    sw $t1, 0($t0)        # Clear old position

    addi $t0, $t0, 128   # Move up one line
    li $t1, 0x0000FF00    # Green (Egg 2 color)
    sw $t1, 0($t0)        # Draw at new position

    sw $t0, egg2          # Update Egg 2 position in memory
    jr $ra
    
   

end_game:
    li $v0, 10             # Exit program
    syscall