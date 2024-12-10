.data 
	Red: .word 0xff0000	#color red
	Green: .word 0x00ff00	#color green
	BA: .word 0x10010000
	
.text
	#I want to print the left half of the btimap display in red and the right half in green \
	#so bedde ballich men column 0 till half so till 1024 / 2 = 512, when I get there
	#I need to start printing green till I reach 1024 and when I do I start priting Red then do 
	#the whole process again and again so I need a sentinel value
	
	#I need a counter for the total number of pixel for each side
	#I need a second counter for the left side
	#And a thrid counter for the right side
	lw $t0, Red	#t0 = hexadecimal address of the color I want to print
	lw $t1, BA	#t1 = base address of the bitmap display
	li $t2, 131072	#t2 = total number of pixels
	li $t3, 256	#delimiter for when to stop printing red and start printing green
	li $t4, 0	#counter for pixels in each row

#PRINTING RED PART
RED_1:
	lw $t0, Red
	li $t4, 0
	RED_LOOP:
	sw $t0, 0($t1)		#storing the color in the memory in order to display it
	addi $t1, $t1, 4
	addi $t4, $t4, 1	#incrementing the column counter
	addi $t2, $t2, -1	#decrementing the total pixel counter
	beq $t2, $zero, end
	beq $t4, $t3, GREEN_1
	j RED_LOOP
	
#PRINTING GREEN PART
GREEN_1:
	li $t0,	0x00ff00
	li $t4, 0
	GREEN_LOOP:
	sw $t0, 0($t1)
	addi $t1, $t1, 4
	addi $t4, $t4, 1
	addi $t2, $t2, -1
	beq $t2, $zero, end
	beq $t4, $t3, RED_1
	j GREEN_LOOP

end: 
	li $v0, 10
	syscall