
#############################################
#                                           #
#     Name: Alejandro Caro (APC)            #
#     Date: June 13th, 2025                 #
#     Class: CDA 3100                       #
#     Assignment: #3 Read in three numbers  #
#     and work with sum, difference,        #
#     product, division and shifting.       #
#                                           #
#############################################

.data
intro:      .asciiz "Alejandro Caro - CDA3100\nAdd, Subtract, Multiply and Divide three numbers\n"
prompt1:    .asciiz "Enter the first number: "
prompt2:    .asciiz "Enter the second number: "
prompt3:    .asciiz "Enter the third number: "
invalid:    .asciiz "*** Warning Will Robinson…The number is below 1. ***\n"
sumText:    .asciiz "\nSum: "
diffText:   .asciiz "\nDifference: "
prodText:   .asciiz "\nProduct: "
quotText:   .asciiz "\nQuotient: "
remText:    .asciiz "\nRemainder: "
shiftLeft:  .asciiz "\nNUM1 Shift Left 1: "
shiftRight: .asciiz "\nNUM2 Shift Right 2: "
endText:    .asciiz "\nThe program has stopped.. may the force be with you.\n"
newline:    .asciiz "\n"

NUM1:       .word 0         # Variable to store first number
NUM2:       .word 0         # Variable to store second number
NUM3:       .word 0         # Variable to store third number

.text
.globl main

main:
    # Print intro message
    li $v0, 4                 # Load syscall code for print string
    la $a0, intro             # Load address of intro string
    syscall                   # Print intro message

    # --- Input NUM1 ---
    li $v0, 4                 # Print prompt1
    la $a0, prompt1
    syscall

    li $v0, 5                 # Load syscall code for reading int
    syscall
    move $t0, $v0             # Store input in $t0
    blt $t0, 1, invalid_input # If input < 1, jump to error
    sw $t0, NUM1              # Save to NUM1

    # --- Input NUM2 ---
    li $v0, 4
    la $a0, prompt2
    syscall

    li $v0, 5
    syscall
    move $t1, $v0             # Store input in $t1
    blt $t1, 1, invalid_input # If input < 1, jump to error
    sw $t1, NUM2              # Save to NUM2

    # --- Input NUM3 ---
    li $v0, 4
    la $a0, prompt3
    syscall

    li $v0, 5
    syscall
    move $t2, $v0             # Store input in $t2
    blt $t2, 1, invalid_input # If input < 1, jump to error
    sw $t2, NUM3              # Save to NUM3

    # --- Sum ---
    add $t3, $t0, $t1         # $t3 = NUM1 + NUM2
    add $t3, $t3, $t2         # $t3 = $t3 + NUM3
    li $v0, 4
    la $a0, sumText
    syscall                   # Print "Sum:"

    li $v0, 1
    move $a0, $t3             # Load sum value
    syscall                   # Print sum
    li $v0, 4
    la $a0, newline
    syscall                   # Print newline

    # --- Difference (NUM1 - NUM2) ---
    sub $t4, $t0, $t1         # $t4 = NUM1 - NUM2
    li $v0, 4
    la $a0, diffText
    syscall                   # Print "Difference:"

    li $v0, 1
    move $a0, $t4             # Load difference
    syscall                   # Print difference
    li $v0, 4
    la $a0, newline
    syscall                   # Print newline

    # --- Product ---
    mul $t5, $t0, $t1         # $t5 = NUM1 * NUM2
    mul $t5, $t5, $t2         # $t5 = $t5 * NUM3
    li $v0, 4
    la $a0, prodText
    syscall                   # Print "Product:"

    li $v0, 1
    move $a0, $t5             # Load product
    syscall                   # Print product
    li $v0, 4
    la $a0, newline
    syscall                   # Print newline

    # --- Quotient and Remainder (NUM2 / NUM3) ---
    div $t1, $t2              # Divide NUM2 by NUM3
    mflo $t6                  # Move quotient to $t6
    mfhi $t7                  # Move remainder to $t7

    li $v0, 4
    la $a0, quotText
    syscall                   # Print "Quotient:"
    li $v0, 1
    move $a0, $t6             # Load quotient
    syscall                   # Print quotient
    li $v0, 4
    la $a0, newline
    syscall                   # Print newline

    li $v0, 4
    la $a0, remText
    syscall                   # Print "Remainder:"
    li $v0, 1
    move $a0, $t7             # Load remainder
    syscall                   # Print remainder
    li $v0, 4
    la $a0, newline
    syscall                   # Print newline

    # --- Shift Left NUM1 by 1 ---
    sll $t8, $t0, 1           # $t8 = NUM1 << 1
    li $v0, 4
    la $a0, shiftLeft
    syscall                   # Print shift left message
    li $v0, 1
    move $a0, $t8             # Load shifted value
    syscall                   # Print result
    li $v0, 4
    la $a0, newline
    syscall                   # Print newline

    # --- Shift Right NUM2 by 2 ---
    srl $t9, $t1, 2           # $t9 = NUM2 >> 2
    li $v0, 4
    la $a0, shiftRight
    syscall                   # Print shift right message
    li $v0, 1
    move $a0, $t9             # Load shifted value
    syscall                   # Print result
    li $v0, 4
    la $a0, newline
    syscall                   # Print newline

    # --- Ending Message ---
    li $v0, 4
    la $a0, endText
    syscall                   # Print program end message

    li $v0, 10
    syscall                   # Exit program

# --- Handle Invalid Input ---
invalid_input:
    li $v0, 4
    la $a0, invalid
    syscall                   # Print invalid input message

    li $v0, 10
    syscall                   # Exit program
