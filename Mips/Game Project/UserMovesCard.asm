.data
    Red: .word 0xff0000
    BaseAddress: .word 0x10010000

.text
.globl main

main:
    # Initialize the pixel
    lw $t0, Red
    lw $t1, BaseAddress
    sw $t0, 0($t1)

    loop:
        # Wait for a keypress
        #lw $t0, status_reg
        #beqz $t0, loop

        # Read the keycode
        lw $t2, 0xffff0004

        # Check if it's the right arrow key
        li $t3, 100  # ASCII code for d
        bne $t2, $t3, loop

        # Move the pixel to the right
        lw $t0, Red
        lw $t1, BaseAddress
        li $t2, 0x000000
        sw $t2, 0($t1)
        
        addi $t1, $t1, 4  # Increment the address by 4 bytes
        sw $t0, 0($t1)

        j loop

    # Exit the program
    li $v0, 10
    syscall
