.data
base_prompt: .asciiz "Enter the base of the triangle: "
base_is: .asciiz "Base is: "

height_prompt: .asciiz "\n\nEnter the height of the triangle: "
height_is: .asciiz "Height is: "

result_prompt: .asciiz "\n\nArea is: "

const2: .float 2.0

.text
#.globl main

main:
    # Print base prompt
    li $v0, 4           # Load system call for printing string
    la $a0, base_prompt # Load base prompt string address
    syscall             # Print base prompt
    
    li $v0, 6           # Load system call for reading float
    syscall             # Read base
  
   mov.s $f1,$f0	#move in single floating point the user input into f1
  
  # Print base_is 
    li $v0, 4           # Load system call for printing string
    la $a0, base_is 	# Load base prompt string address
    syscall             # Print base is prompt
    
    li $v0, 2		#we are checking to see if the value was indeed taken in base
    mov.s $f12,$f0
    syscall
    
    # Print height prompt
    li $v0, 4           # Load system call for printing string
    la $a0, height_prompt # Load height prompt string address
    syscall             # Print height prompt
    
    li $v0, 6           # Load system call for reading float
    syscall             # Read height
    
    mov.s $f2,$f0	#move in single floating point the user input into f2
    
    # Print height_is 
    li $v0, 4           # Load system call for printing string
    la $a0, height_is 	# Load height_is string address
    syscall             # Print height_is 
    
    li $v0, 2		#we are checking to see if the value was indeed taken in height
    mov.s $f12,$f0	#move what we want to print into $f12
    syscall
    
     # Print result prompt
    li $v0, 4           # Load system call for printing string
    la $a0, result_prompt # Load base prompt string address
    syscall             # Print height prompt
    
    mul.s $f1, $f1, $f2 #multiply base and height and store in $f1
    
    lwc1 $f5, const2
    div.s $f1, $f1, $f5
    mov.s $f12, $f1
    
    li $v0, 2
    syscall
    
    li $v0, 10
    syscall