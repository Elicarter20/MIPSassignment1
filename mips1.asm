#You will write a MIPS program that reads a string of up to 8 characters from user input. 
#If the string has only the characters from '0' to '9' and from 'a' to 'f' and from 'A' to 'F', 
#the program prints out the unsigned decimal integer corresponding to the hexadecimal number in the string. 
#Otherwise, the program prints out the message of "Invalid hexadecimal number.".
# $s0 where you read in char
# $s1 - character count
# $a0, $t0 - userInput 

.data
	message: .asciiz "Please enter a string-- "
	userInput: .space 9
	nl: "\n"
	error: "Invalid hexadecimal number"
.text

	main:
		
		#to read is 8 to display is 4
		
		
		
		# displays message
		li $v0, 4
		la $a0, message
		syscall
		
		#reads in text entered by the user
		li $v0, 8
		la $a0, userInput
		li $a1, 9
		syscall
		
		#displays userinput
		li $v0, 4
		la $a0, userInput
		syscall
		
		#Iterates through the string
		
		la $t0, userInput
		li $s1 ,0
loop:		
		#loads and prints character from string
		lb $a0, 0($t0)
		li $v0, 11
		syscall
		
		#needed for the comparison at then end of the loop
		add $s0, $0, $a0
		
		#print newline
		li $v0, 4
		la $a0, nl
		syscall
		
		#check if at endline and will read in next byte
		addi $t0, $t0, 1
		beq $s0, 0, exit
		beq $s0, 10, exit
		addi $s1, $s1, 1
		j loop
		
		la $t0, userInput
loop2:
		#loads and prints character from string 
		lb $a0, 0($t0)
		li $v0, 11
		
		
		#needed for the comparison at then end of the loop
		add $s0, $0, $a0
		
		 #checks if char is greater than f or less than 0
		blt $s0, 48, exitNV
		bgt $s0, 103, exitNV
		
		#check if at endline and will read in next byte
		addi $t0, $t0, 1
		beq $s0, 0, exit
		beq $s0, 10, exit
		j loop2
		
		
		
		
		
		
	
	
	exit:
		
		li $v0,10 #loads the service that exits
              	syscall
              	
      	exitNV: 
      		li $v0, 4
		la $a0, error
		syscall
		
      		li $v0,10 #loads the service that exits
              	syscall
	#Loop:
		#add $s1, $a0, $t0 
		#lb $s2, 0($s1)
		#beq $s2, $zero, exit
		#beq $s2, 
		#addi $t0, $t0, 1
		#j Loop
