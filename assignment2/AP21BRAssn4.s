#############################################
#                                           #
#     Name: Alejandro Caro (APC)            #
#     Date: June 26th, 2025                 #
#     Class: CDA 3100                       #
#     Assignment: #4 Process five integers, #
#     converting to float, and calculating  #
#     sum, mean, range, and variance.       #
#                                           #
#############################################

# -----------------------------
#   DATA SEGMENT
# -----------------------------
.data
intro:          .asciiz "Enter 5 integer numbers:\n"
prompt:         .asciiz "Enter another Number: "
listHeader:     .asciiz "\nFloating Point List\n"
sumLabel:       .asciiz "\nThe Sum of the numbers is: "
minLabel:       .asciiz "\nThe Smallest number is: "
maxLabel:       .asciiz "\nThe Largest number is: "
meanLabel:      .asciiz "\nThe Mean of the numbers is: "
varLabel:       .asciiz "\nThe variance of the numbers is: "
newline:        .asciiz "\n"

intArray:       .word 0:5              # Aligned storage for 5 integers
floatArray:     .float 0.0, 0.0, 0.0, 0.0, 0.0   # Aligned storage for 5 floats

# -----------------------------
#   TEXT SEGMENT
# -----------------------------
.text
.globl main

main:
    # -----------------------------
    #   PRINT INTRO
    # -----------------------------
    li $v0, 4
    la $a0, intro
    syscall

    # -----------------------------
    #   INPUT & CONVERSION LOOP
    # -----------------------------
    li $t0, 0                 # Index counter for input
input_loop:
    li $v0, 4                # Print prompt
    la $a0, prompt
    syscall

    li $v0, 5                # Read integer input
    syscall

    la $t1, intArray         # Load base address of intArray
    mul $t2, $t0, 4          # Calculate offset = index * 4
    add $t1, $t1, $t2        # Point to correct word in array
    sw $v0, 0($t1)           # Store integer

    mtc1 $v0, $f0            # Move integer to FP register
    cvt.s.w $f0, $f0         # Convert int to float

    la $t3, floatArray       # Load base address of floatArray
    add $t3, $t3, $t2        # Offset to correct float index
    s.s $f0, 0($t3)          # Store float

    addi $t0, $t0, 1         # Increment index
    li $t4, 5
    blt $t0, $t4, input_loop # Repeat for 5 values

    # -----------------------------
    #   PRINT FLOAT ARRAY
    # -----------------------------
    li $v0, 4
    la $a0, listHeader
    syscall

    li $t0, 0                # Reset index
print_loop:
    la $t1, floatArray       # Get base address
    mul $t2, $t0, 4          # Calculate offset
    add $t1, $t1, $t2        # Get address of element
    l.s $f12, 0($t1)         # Load float into $f12

    li $v0, 2                # Print float
    syscall

    li $v0, 4
    la $a0, newline          # Print newline
    syscall

    addi $t0, $t0, 1
    li $t4, 5
    blt $t0, $t4, print_loop # Loop through all floats

    # -----------------------------
    #   CALCULATE SUM, MIN, MAX
    # -----------------------------
    li.s $f2, 0.0            # f2 = sum
    li $t0, 0                # Reset index
    la $t1, floatArray       # Pointer to start of float array
    l.s $f3, 0($t1)          # f3 = min initialized
    l.s $f4, 0($t1)          # f4 = max initialized
calc_loop:
    mul $t2, $t0, 4          # Calculate offset
    add $t5, $t1, $t2        # Get address of floatArray[i]
    l.s $f1, 0($t5)          # Load current float
    add.s $f2, $f2, $f1      # sum += value

    c.lt.s $f1, $f3          # if value < min
    bc1t new_min
    j min_check_done
new_min:
    mov.s $f3, $f1           # update min
min_check_done:

    c.lt.s $f4, $f1          # if value > max
    bc1t new_max
    j max_check_done
new_max:
    mov.s $f4, $f1           # update max
max_check_done:

    addi $t0, $t0, 1         # Increment index
    li $t6, 5
    blt $t0, $t6, calc_loop  # Loop through all 5 values

    # -----------------------------
    #   CALCULATE MEAN
    # -----------------------------
    li.s $f5, 5.0
    div.s $f6, $f2, $f5      # f6 = mean

    # -----------------------------
    #   CALCULATE VARIANCE (sample variance using n - 1 = 4)
    # -----------------------------
    li.s $f5, 4.0            # Use n - 1 = 4 for sample variance
    li.s $f7, 0.0            # Reset variance sum
    la $t1, floatArray       # Load base address once (outside loop)
    li $t0, 0                # Reset index
    li $t4, 5                # Loop limit
variance_loop:
    mul $t2, $t0, 4          # Calculate offset
    add $t3, $t1, $t2        # Calculate address = base + offset
    l.s $f8, 0($t3)          # Load x_i from array
    sub.s $f9, $f8, $f6      # x_i - mean
    mul.s $f10, $f9, $f9     # (x_i - mean)^2
    add.s $f7, $f7, $f10     # Add to total variance sum

    addi $t0, $t0, 1
    blt $t0, $t4, variance_loop

    div.s $f11, $f7, $f5     # variance = sum / (n - 1)

    # -----------------------------
    #   OUTPUT RESULTS
    # -----------------------------

    # Output the total sum of the five floating-point values
    li $v0, 4
    la $a0, sumLabel
    syscall
    mov.s $f12, $f2
    li $v0, 2
    syscall

    # Output the smallest (minimum) value from the five inputs
    li $v0, 4
    la $a0, minLabel
    syscall
    mov.s $f12, $f3
    li $v0, 2
    syscall

    # Output the largest (maximum) value from the five inputs
    li $v0, 4
    la $a0, maxLabel
    syscall
    mov.s $f12, $f4
    li $v0, 2
    syscall

    # Output the average (mean) value calculated from the inputs
    li $v0, 4
    la $a0, meanLabel
    syscall
    mov.s $f12, $f6
    li $v0, 2
    syscall

    # Output the variance, a measure of how spread out the values are
    li $v0, 4
    la $a0, varLabel
    syscall
    mov.s $f12, $f11
    li $v0, 2
    syscall

    # -----------------------------
    #   END PROGRAM
    # -----------------------------
    li $v0, 10
    syscall
