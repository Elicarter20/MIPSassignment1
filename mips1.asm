#You will write a MIPS program that reads a string of up to 8 characters from user input. 
#If the string has only the characters from '0' to '9' and from 'a' to 'f' and from 'A' to 'F', 
#the program prints out the unsigned decimal integer corresponding to the hexadecimal number in the string. 
#Otherwise, the program prints out the message of "Invalid hexadecimal number.".
# $s0 where you read in char
# $s1 - character count
# $a0, $t0 - userInput 
# $s2 - final answer
.data
	message: .asciiz "Please enter a string-- "
	userInput: .space 9
	nl: "\n"
	error: "Invalid hexadecimal number"
.text

	main:
		
		#to read is 8 to display is 4
		
		li $s2, 0
		
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
		#syscall
		
		#needed for the comparison at then end of the loop
		add $s0, $0, $a0
		
		#print newline
		li $v0, 4
		la $a0, nl
		syscall
		
		#check if at endline and will read in next byte
		addi $t0, $t0, 1
		beq $s0, 0, callLoop2
		beq $s0, 10, callLoop2
		addi $s1, $s1, 1
		j loop
		
		
		
		
		
loop2:		
		lb $a0, 0($t0)
		li $v0, 11
		
		#needed for the comparison at then end of the loop
		add $s0, $0, $a0
		beq $s0, 0, exit
		beq $s0, 10, exit
		addi $t0, $t0, 1
		
		#checks if char is greater than f or less than 0
		blt $s0, 48, exitNV
		bgt $s0, 104, exitNV
		
		#checks if char is greater than 0
		bge $s0, 48, great0
		
		#check if at endline and will read in next byte
		
		
		
		j loop2
		

callLoop2:
		la $t0, userInput
		j loop2
              	
exitNV: 
      		li $v0, 4
		la $a0, error
		syscall
		
      		li $v0,10 #loads the service that exits
              	syscall
exit: 
		add $a0, $s2, $0
		li $v0, 36
		syscall
				
		li $v0,10 #loads the service that exits
              	syscall
great0:
		blt $s0, 58, less9 #between 0 and 9
		bge $s0, 58, great9
great9:
		ble $s0, 64, exitNV
		bgt $s0, 64, greatA 
less9:
		li $t1, 0 #to store the conversion
		addi $t1, $s0, -48
		add $s3, $0, $s1 # store length so we can use it
		addi $s3, $s3, -1 #sub 1 from length for calaculation
		sll $s3, $s3, 2 # multiply by four to get shif afount(pow(16,len))
		
		sllv $s3, $t1, $s3 
		add $s2, $s2, $s3
		addi $s1, $s1, -1  # decrements length by 1
		j loop2
		 				
greatA:				               	
		blt $s0, 71, lessF
		bge $s0, 72, greatF
greatF:
		ble $s0, 96, exitNV
		bgt $s0, 96, greata
		
lessF:
		li $t1, 0 #to store the conversion
		addi $t1, $s0, -55
		add $s3, $0, $s1 # store length so we can use it
		addi $s3, $s3, -1 #sub 1 from length for calaculation
		sll $s3, $s3, 2 # multiply by four to get shif afount(pow(16,len))
		
		sllv $s3, $t1, $s3 
		add $s2, $s2, $s3
		addi $s1, $s1, -1  # decrements length by 1
		j loop2
greata:
		#blt $s0, 103, lessf 

		li $t1, 0 #to store the conversion
		addi $t1, $s0, -87
		add $s3, $0, $s1 # store length so we can use it
		addi $s3, $s3, -1 #sub 1 from length for calaculation
		sll $s3, $s3, 2 # multiply by four to get shif afount(pow(16,len))
		sllv $s3, $t1, $s3 
		add $s2, $s2, $s3
		addi $s1, $s1, -1  # decrements length by 1
		j loop2
		
	
