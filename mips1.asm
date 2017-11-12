#You will write a MIPS program that reads a string of up to 8 characters from user input. 
#If the string has only the characters from '0' to '9' and from 'a' to 'f' and from 'A' to 'F', 
#the program prints out the unsigned decimal integer corresponding to the hexadecimal number in the string. 
#Otherwise, the program prints out the message of "Invalid hexadecimal number.".
.data
	message: .asciiz "enter text "
	userInput: .space 8
.text

	main:
		
		#to read is 8 to display is 4
		
		#reads int text entered by the user
		li $v0, 8
		la $a0, userInput
		li $a1, 8
		syscall
		
		# displays message
		li $v0, 4
		la $a0, message
		syscall
		#displays userinput
		li $v0, 4
		la $a0, userInput
		syscall
	
	li $v0, 10
	syscall