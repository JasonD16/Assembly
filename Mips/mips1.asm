.data
base_prompt: .asciiz "Enter the base of the triangle: "
base_is: .asciiz "Base is: "

height_prompt: .asciiz "\n\nEnter the height of the triangle: "
height_is: .asciiz "Height is: "

result_prompt: .asciiz "\n\nArea is: "

.text
.globl main

main:
    # Print base prompt
    li $v0, 4           # Load system call for printing string
    la $a0, base_prompt # Load base prompt string address
    syscall             # Print base prompt
    
    li $v0, 6           # Load system call for reading float
    syscall             # Read base
  
   mov.s $f1,$f0
  
  # Print base_is 
    li $v0, 4           # Load system call for printing string
    la $a0, base_is 	# Load base prompt string address
    syscall             # Print base is prompt
    
    li $v0, 2		#we are checking to see if the value was indeed taken in base
    mov.s $f12,$f0
    syscall
    
    # Print height prompt
    li $v0, 4           # Load system call for printing string
    la $a0, height_prompt # Load base prompt string address
    syscall             # Print height prompt
    
    li $v0, 6           # Load system call for reading float
    syscall             # Read base
    
    mov.s $f2,$f0
    
    # Print height_is 
    li $v0, 4           # Load system call for printing string
    la $a0, height_is 	# Load height_is string address
    syscall             # Print height_is 
    
    li $v0, 2		#we are checking to see if the value was indeed taken in height
    mov.s $f12,$f0
    syscall
    
     # Print result prompt
    li $v0, 4           # Load system call for printing string
    la $a0, result_prompt # Load base prompt string address
    syscall             # Print height prompt
    
    mul.s $f1, $f1, $f2 #multiply base and height
    
    li $t0, 2
    mtc1 $t0, $f2
    cvt.s.w $f2, $f2 
    
    div.s $f1, $f1, $f2
    
    li $v0, 2
    mov.s $f12, $f1
    syscall
    
    #exit the program
    li $v0, 10
    syscall