#################################################
#						#
#						#
#               FINAL PROJECT 			#
#	            BY 				#
#        Guillaume Sawaya  #ID:			#
#						#
#        Elie Moukawam    #ID: 20231732		#
#						#
#						#
#################################################

												#####################################
												#				    #
												#				    #
									#Plane GAME TITLE:      #  Not so safe Boeing737 adventure  #
												#				    #
												#				    #
                                                                          			#####################################
#Bitmap Display
# Unit Width: 1
# Unit Height: 1
# Display Width: 512
# Display Height: 256
# Base Address: Static Data

# Black object is the aircraft
# Green objects are the health kits
# White building is the fortress
# Pressing SPACE will start the game
# Aircraft can be controlled with 'w' and 's' keys
# Aircraft has total of 3 health points
# If you hit a bird in red, you lose 1 health point
# Health kit gives you 1 health point

# Display Attributes
.eqv Display_Width 512
.eqv Display_Height 256
.eqv Origin 0x10010000

# Aircraft Attributes
.eqv Aircraft_Width 100
.eqv Aircraft_Height 50
.eqv Aircraft_X_Coord 30
.eqv Aircraft_Up_Coord 20
.eqv Aircraft_Mid_Coord 100
.eqv Aircraft_Down_Coord 180

# Buttons
.eqv W_Button 119
.eqv S_Button 115
.eqv Spc_Button 32

# Bird Attributes
.eqv Bird_Size 25
.eqv Bird_X_Coord 400
.eqv Bird_Up_Coord 30
.eqv Bird_Mid_Coord 110
.eqv Bird_Down_Coord 190

# Health Attributes
.eqv Health_Kit_Size 25
.eqv Health_Kit_X_Coord 400
.eqv Health_Kit_Up_Coord 30
.eqv Health_Kit_Mid_Coord 110
.eqv Health_Kit_Down_Coord 190

# Fortress Attributes
.eqv Fortress_Width 25
.eqv Fortress_Height 256
.eqv Fortress_X_Coord 487
.eqv Fortress_Y_Coord 0

# Colors
.eqv Cyan 0x0000FFFF # Sky
.eqv Black 0x00000000 # Aircraft
.eqv Red 0x00FF0000# Birds
.eqv Green 0x0000FF00 # Health
.eqv White 0xFFFFFFFF # Fortress

.macro Sleep_100ms
li $v0, 32
li $a0, 100
syscall
.end_macro

.macro Sleep_10ms
li $v0, 32
li $a0, 10
syscall
.end_macro

.macro Print_Health
li $v0, 1
add $a0, $zero, $t6
syscall
.end_macro

.data

Welcome_Text: .asciiz "Welcome to Boeing737! Press SPACE to begin.\n"

.text

main:
	li $v0, 4
        la $a0, Welcome_Text
        syscall

        jal Draw_Sky

        li $a0, Aircraft_X_Coord
        li $a2, Aircraft_Mid_Coord
        jal Draw_Aircraft	

        li $t9, Aircraft_Mid_Coord
        jal Game_Start

        lw $ra, 0($sp)
        addiu, $sp, $sp, 4

        li $v0, 10
        syscall


# Parameters: $a0: x_coordinate, $a1: width, $a2: y_coordinate, $a3: height
Draw_Object:
	addiu $sp, $sp, -4
	sw $ra, 0($sp)

	la $t1, Origin

        add $a1, $a1, $a0
	add $a3, $a3, $a2

	sll $a0, $a0, 2
	sll $a1, $a1, 2
	sll $a2, $a2, 11
	sll $a3, $a3, 11

	addu $t2, $a2, $t1
	addu $a3, $a3, $t1
	addu $a2, $t2, $a0
	addu $a3, $a3, $a0
	addu $t2, $t2, $a1

	li $t4, 0x800

Draw_Object_Y_Axis:
	add $t3, $zero, $a2

	Draw_Object_X_Axis:
		sw $s0, 0($t3)
		addi $t3, $t3, 4
		bne $t3, $t2, Draw_Object_X_Axis
	
	addu $a2, $a2, $t4
	addu $t2, $t2, $t4
	bne $a3, $a2, Draw_Object_Y_Axis

	lw $ra, 0($sp)
	addiu, $sp, $sp, 4

	jr $ra


Draw_Sky:
	addiu $sp, $sp, -4
	sw $ra, 0($sp)
	
	addi $s0, $zero, Cyan
	li $a0, 0
	li $a1, 512
	li $a2, 0
	li $a3, 256
	
	jal Draw_Object

	lw $ra, 0($sp)
	addiu, $sp, $sp, 4

	jr $ra


# Parameters: $a0 = Aircraft's x axis, $a2 = Aircraft's y axis
Draw_Aircraft:
	addiu $sp, $sp, -4
	sw $ra, 0($sp)
	
	addi $s0, $zero, Black
	li $a1, Aircraft_Width
	li $a3, Aircraft_Height

	jal Draw_Object

	lw $ra, 0($sp)
	addiu, $sp, $sp, 4

	jr $ra


Draw_Bird:
	addiu $sp, $sp, -4
	sw $ra, 0($sp)
	
	addi $s0, $zero, Red
	li $a1, Bird_Size
	li $a3, Bird_Size

	jal Draw_Object

	lw $ra, 0($sp)
	addiu, $sp, $sp, 4

	jr $ra


Draw_Health_Kit:
	addiu $sp, $sp, -4
	sw $ra, 0($sp)
	
	addi $s0, $zero, Green
	li $a1, Health_Kit_Size
	li $a3, Health_Kit_Size
	jal Draw_Object

	lw $ra, 0($sp)
	addiu, $sp, $sp, 4

	jr $ra


Draw_Fortress:
	addiu $sp, $sp, -4
	sw $ra, 0($sp)
	
	addi $s0, $zero, White
	li $a0, Fortress_X_Coord
	li $a1, Fortress_Width
	li $a2, Fortress_Y_Coord
	li $a3, Fortress_Height

	jal Draw_Object

	lw $ra, 0($sp)
	addiu, $sp, $sp, 4

	jr $ra


Game_Start:
	addiu $sp, $sp, -4
	sw $ra, 0($sp)

	Pool_Loop:
	lw $t0, 0xffff0000
	andi $t0, $t0, 0x0001
	beq $t0, $zero, Pool_Loop

	lw $t1, 0xffff0004

	 beq $t1, Spc_Button, Game_Begin
	j Pool_Loop

	lw $ra, 0($sp)
	addiu, $sp, $sp, 4

	jr $ra


Listen_Button:
	addiu $sp, $sp, -4
	sw $ra, 0($sp)

	lw $t0, 0xffff0000
	andi $t0, $t0, 0x0001	

	bne $t0, 1, End_Listen

	lw $t1, 0xffff0004

	beq $t1, W_Button, W_Button_Pressed
	beq $t1, S_Button, S_Button_Pressed

W_Button_Pressed:
	ble $t9, Aircraft_Up_Coord, End_Listen

	addiu $t9, $t9, -80

	beq $t9, Aircraft_Mid_Coord, Draw_Mid_W
	beq $t9, Aircraft_Up_Coord, Draw_Upper_W

	Draw_Mid_W: 
		li $a0, Aircraft_X_Coord
		li $a2, Aircraft_Down_Coord
		jal Aircraft_Relocate
		
		li $a0, Aircraft_X_Coord
		li $a2, Aircraft_Mid_Coord
		jal Draw_Aircraft
		
		j End_Listen
	
	Draw_Upper_W:
		li $a0, Aircraft_X_Coord
		li $a2, Aircraft_Mid_Coord
		jal Aircraft_Relocate

		li $a0, Aircraft_X_Coord	
		li $a2, Aircraft_Up_Coord
		jal Draw_Aircraft
	
		j End_Listen
		
		
	S_Button_Pressed:
	bge $t9, Aircraft_Down_Coord, End_Listen

	addiu $t9, $t9, 80

	beq $t9, Aircraft_Down_Coord, Draw_Down_S
	beq $t9, Aircraft_Mid_Coord, Draw_Mid_S

	Draw_Down_S: 
		li $a0, Aircraft_X_Coord
		li $a2, Aircraft_Mid_Coord
		jal Aircraft_Relocate
		
		li $a0, Aircraft_X_Coord
		li $a2, Aircraft_Down_Coord
		jal Draw_Aircraft
		
		j End_Listen
	
	Draw_Mid_S:
		li $a0, Aircraft_X_Coord
		li $a2, Aircraft_Up_Coord
		jal Aircraft_Relocate

		li $a0, Aircraft_X_Coord	
		li $a2, Aircraft_Mid_Coord
		jal Draw_Aircraft
	
		j End_Listen
		

End_Listen:	
	lw $ra, 0($sp)
	addiu, $sp, $sp, 4

	jr $ra


Game_Begin:
	addiu $sp, $sp, -4
	sw $ra, 0($sp)	
	
	li $t6, 2
	li $s6, 1
	
	li $s4, Bird_Up_Coord
	li $s5, Bird_Mid_Coord
	jal Bird_Wave
	
	li $s4, Bird_Mid_Coord
	li $s5, Bird_Down_Coord
	jal Bird_Wave
	
	li $s4, Bird_Up_Coord
	li $s5, Bird_Mid_Coord
	jal Bird_Wave
	
	li $s4, Bird_Mid_Coord
	li $s5, Bird_Down_Coord
	jal Bird_Wave
	
	li $s4, Bird_Up_Coord
	li $s5, Bird_Down_Coord
	jal Bird_Wave
	
	jal Draw_Fortress
	
	jal Aircraft_Flies_To_Fortress
	
	lw $ra, 0($sp)
	addiu, $sp, $sp, 4
	
	jr $ra


# Parameters: $a0 = Aircraft's x axis, $a2 = Aircraft's y axis
Aircraft_Relocate:
	addiu $sp, $sp, -4
	sw $ra, 0($sp)
	
	addi $s0, $zero, Cyan
	li $a1, Aircraft_Width
	li $a3, Aircraft_Height
	
	jal Draw_Object
	
	lw $ra, 0($sp)
	addiu, $sp, $sp, 4
	
	jr $ra

# Parameters: $a0 = Bird's x axis, $a2 = Bird's y axis
Bird_Relocate:
	addiu $sp, $sp, -4
	sw $ra, 0($sp)
	
	addi $s0, $zero, Cyan
	li $a1, Bird_Size
	li $a3, Bird_Size
	
	jal Draw_Object
	
	lw $ra, 0($sp)
	addiu, $sp, $sp, 4
	
	jr $ra

# Parameters: $a0 = Health Kit's x axis, $a2 = Health Kit's y axis
Health_Kit_Relocate:
	addiu $sp, $sp, -4
	sw $ra, 0($sp)
	
	addi $s0, $zero, Cyan
	li $a1, Health_Kit_Size
	li $a3, Health_Kit_Size
	
	jal Draw_Object
	
	lw $ra, 0($sp)
	addiu, $sp, $sp, 4
	
	jr $ra

Check_Health:
	addiu $sp, $sp, -4
	sw $ra, 0($sp)

	beq $t5, 9, Object_Touches_Aircraft
	j Check_Health_Return
	
	Object_Touches_Aircraft:
		
		subi $s4, $s4, 10
		subi $s5, $s5, 10
		
		beq $t9, $s4, Bird_Hit_Aircraft
		beq $t9, $s5, Bird_Hit_Aircraft
		
		addi $s4, $s4, 10
		addi $s5, $s5, 10
		
		beq $s6, 3, Health_Kit_Touches_Aircraft
		j Check_Health_Return
		
	Health_Kit_Touches_Aircraft:
		li $s1, Health_Kit_Down_Coord
		subi $s7, $s1, 10
	
		beq $t9, $s7, Health_Kit_Taken
		
		j Check_Health_Return
			
	Bird_Hit_Aircraft:
		subi $t6, $t6, 1
		
		Print_Health
		
		addi $s4, $s4, 10
		addi $s5, $s5, 10
		
		j Is_Game_Ended
	
	Health_Kit_Taken:
		beq $t6, 3, Is_Game_Ended
	
		addi $t6, $t6, 1
		
		Print_Health
		
	Is_Game_Ended:
		beqz $t6, End_Game
		j Check_Health_Return

    End_Game: 
   
   Play_Sound:
	li $v0, 31 
	li $a0, 66 
	li $a1, 2000 
	li $a2, 57 
	li $a3, 127 
	syscall
	li $a0, 74 
	li $a1, 500
	syscall 
	
	Check_Health_Return:
		lw $ra, 0($sp)
		addiu, $sp, $sp, 4
		
		jr $ra

# Parameters: $s4 = Bird 1's y axis, $s5 = Bird 2's y axis
Bird_Wave:
	addiu $sp, $sp, -4
	sw $ra, 0($sp)
	
	li $t7, Bird_X_Coord
	li $t8, Health_Kit_X_Coord
	
	li $s3, 13 # Bird movement limit
	move $t5, $zero # Bird movement iteration
	
	Move_Loop:
		
		jal Listen_Button
		
		# Draw Bird 1
		move $a2, $s4	
		move $a0, $t7
				
		jal Draw_Bird
		
		Sleep_10ms
		
		# Draw Bird 2
		move $a2, $s5		
		move $a0, $t7
				
		jal Draw_Bird
		
		# Relocate Bird 1
		move $a2, $s4		
		move $a0, $t7
		
		jal Bird_Relocate
		
		Sleep_10ms

		# Relocate Bird 2
		move $a2, $s5	
		move $a0, $t7
		
		jal Bird_Relocate

		subi $t7, $t7, 30
		
		Sleep_100ms
		
		# Redraw Bird 1
		move $a2, $s4
		move $a0, $t7
		
		jal Draw_Bird
		
		Sleep_10ms
		
		# Redraw Bird 2
		move $a2, $s5
		move $a0, $t7
		
		jal Draw_Bird
				
		beq $s6, 3, Draw_Hkit
		j Continue_Loop
	
		Draw_Hkit:
			move $a0, $t8
			li $a2, Health_Kit_Down_Coord
			jal Draw_Health_Kit
			
			move $a0, $t8
			li $a2, Health_Kit_Down_Coord
			jal Health_Kit_Relocate
			
			subi $t8, $t8, 30
			
			move $a0, $t8
			li $a2, Health_Kit_Down_Coord
			jal Draw_Health_Kit
		
	Continue_Loop:
		subi $s3, $s3, 1
		addi $t5, $t5, 1
		
		jal Check_Health
		
		bnez $s3, Move_Loop
		
	addi $s6, $s6, 1
	
	# Bird 1 Out
	move $a2, $s4		
	move $a0, $t7	
	jal Bird_Relocate
	
	# Bird 2 Out
	move $a2, $s5	
	move $a0, $t7
	jal Bird_Relocate
	
	# Health Kit Out
	move $a0, $t8
	li $a2, Health_Kit_Down_Coord
	jal Health_Kit_Relocate
	
	lw $ra, 0($sp)
	addiu, $sp, $sp, 4
	
	jr $ra

Aircraft_Flies_To_Fortress:
	addiu $sp, $sp, -4
	sw $ra, 0($sp)

	li $s1, 7
	li $t0, Aircraft_X_Coord
	
	move $a0, $t0
	move $a2, $t9
	jal Aircraft_Relocate

	Aircraft_Move_Loop:
	
		move $a0, $t0
		move $a2, $t9
		jal Draw_Aircraft
		
		move $a0, $t0
		move $a2, $t9
		jal Aircraft_Relocate
		
		addi $t0, $t0, 51
		
		Sleep_100ms
		
		move $a0, $t0
		move $a2, $t9
		jal Draw_Aircraft
		
		subi $s1, $s1, 1
	
		bnez $s1, Aircraft_Move_Loop

	lw $ra, 0($sp)
	addiu, $sp, $sp, 4
	
	jr $ra
