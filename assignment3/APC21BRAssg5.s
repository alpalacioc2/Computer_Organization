#################################################################################
# Name: Alejandro Caro                                                          #
# Class: CDA 3100                                                               #
# Assignment: #5 Count the Characters                                           #
# Description:                                                                  #
#   This program reads a string of up to 255 characters                         #
#   and counts how many uppercase letters, lowercase letters,                   #
#   digits, and blanks it contains using modular subroutines.                   #
#################################################################################


.data
welcome_msg:   .asciiz "Welcome to the Character Counting Program\n"
prompt_msg:    .asciiz "Enter a string up to 255 characters:\n"
input_buffer:  .space 256               # Reserve 256 bytes for user input
newline:       .asciiz "\n"
blank_msg:     .asciiz "The number of blanks is: "
lower_msg:     .asciiz "The number of lower case letters is: "
upper_msg:     .asciiz "The number of upper case letters is: "
digit_msg:     .asciiz "The number of digits is: "

.text
.globl main

main:
    # Display welcome message
    li $v0, 4
    la $a0, welcome_msg
    syscall

    # Prompt the user for a string
    li $v0, 4
    la $a0, prompt_msg
    syscall

    # This will read input string into buffer for all the way to 255 characters
    li $v0, 8
    la $a0, input_buffer
    li $a1, 256
    syscall

    # This will call the subroutine to count character types
    la $a0, input_buffer      # Pass address of input string
    jal countChars            # Counts returned in $s0-$s3

    # Move return values into temp registers for output
    move $t0, $s0             # Uppercase count
    move $t1, $s1             # Lowercase count
    move $t2, $s2             # Digit count
    move $t3, $s3             # Blank count

    # Prints the number of blanks(spaces)
    li $v0, 4
    la $a0, blank_msg
    syscall
    li $v0, 1
    move $a0, $t3
    syscall
    li $v0, 4
    la $a0, newline
    syscall

    # Prints number of lowercase letters
    li $v0, 4
    la $a0, lower_msg
    syscall
    li $v0, 1
    move $a0, $t1
    syscall
    li $v0, 4
    la $a0, newline
    syscall

    # Prints number of uppercase letters
    li $v0, 4
    la $a0, upper_msg
    syscall
    li $v0, 1
    move $a0, $t0
    syscall
    li $v0, 4
    la $a0, newline
    syscall

    # Prints number of digits
    li $v0, 4
    la $a0, digit_msg
    syscall
    li $v0, 1
    move $a0, $t2
    syscall
    li $v0, 4
    la $a0, newline
    syscall

    # Exits the program
    li $v0, 10
    syscall

#####################################################
# Function: countChars
# Purpose:
#   Count the number of upper, lower, digit, and blank
#   characters in a null-terminated string.
# Input:
#   $a0 - address of null-terminated input string
# Output:
#   $s0 - upper case count
#   $s1 - lower case count
#   $s2 - digit count
#   $s3 - blank count
#####################################################

countChars:
    # Save return address on stack
    addi $sp, $sp, -4
    sw $ra, 0($sp)

    # Initialize all counts to zero
    li $s0, 0   # Uppercase count
    li $s1, 0   # Lowercase count
    li $s2, 0   # Digit count
    li $s3, 0   # Blank count

    move $t0, $a0  # $t0 points to current character in string

count_loop:
    lb $t1, 0($t0)         # Load byte (character) into $t1
    beqz $t1, count_done   # If null terminator, end loop

    # Check if character is uppercase (ASCII 65 to 90)
    li $t2, 65
    li $t3, 90
    blt $t1, $t2, check_lower      # If less than 'A', skip
    bgt $t1, $t3, check_lower      # If greater than 'Z', skip
    addi $s0, $s0, 1               # Valid uppercase character
    j advance                      # Go to next character

check_lower:
    li $t2, 97
    li $t3, 122
    blt $t1, $t2, check_digit      # If less than 'a', skip
    bgt $t1, $t3, check_digit      # If greater than 'z', skip
    addi $s1, $s1, 1               # Valid lowercase character
    j advance

check_digit:
    li $t2, 48
    li $t3, 57
    blt $t1, $t2, check_blank      # If less than '0', skip
    bgt $t1, $t3, check_blank      # If greater than '9', skip
    addi $s2, $s2, 1               # Valid digit character
    j advance

check_blank:
    li $t2, 32                     # ASCII for space
    beq $t1, $t2, is_blank         # If equal to space, count it
    j advance

is_blank:
    addi $s3, $s3, 1               # Valid blank character

advance:
    addi $t0, $t0, 1               # Move to next character
    j count_loop

count_done:
    # Restore return address and return
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    jr $ra
