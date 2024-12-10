.data
base_prompt: .asciiz "Enter the base of the triangle: "
base_is: .asciiz "Base is: "

height_prompt: .asciiz "\n\nEnter the height of the triangle: "
height_is: .asciiz "Height is: "

result_prompt: .asciiz "\n\nArea is: "

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
    
    li $t0, 2		#load 2 into $t0
    mtc1 $t0, $f2	#move $t0 to $f2
    cvt.s.w $f2, $f2 	#the operation cvt.s.w converts integers of type .word into floats of type .float
    
    div.s $f1, $f1, $f2	#Area = (base * height) / 2
    
    #printing the result
    li $v0, 2
    mov.s $f12, $f1
    syscall
    
    #exit the program
    li $v0, 10
    syscall
