# CDA3100 – Assignment #3  

## Project Information  
**Name:** Alejandro Caro (APC)  
**Date:** June 13th, 2025  
**Class:** CDA 3100 – Computer Organization I  
**Assignment:** #3 – Read in three numbers and perform arithmetic operations (sum, difference, product, division, remainder) and bitwise shifts.  

---

## Description  
This MIPS assembly program prompts the user to input three integers (NUM1, NUM2, and NUM3). It validates input values (must be ≥ 1) and then performs the following operations:  

-  **Addition** → NUM1 + NUM2 + NUM3  
-  **Subtraction** → NUM1 – NUM2  
-  **Multiplication** → NUM1 × NUM2 × NUM3  
-  **Division** → NUM2 ÷ NUM3 (with quotient and remainder)  
-  **Shift Left** → NUM1 << 1  
-  **Shift Right** → NUM2 >> 2  

The program uses MIPS syscalls for input/output and includes input validation. If a user enters a number below 1, a warning is displayed, and the program terminates.  

---

##  How to Run  

1. Copy the `.asm` file into your working directory.  
2. Open **MARS** or **QtSpim** MIPS simulator.  
3. Load the program:  
   - `File > Open > assignment3.asm`  
4. Assemble and run the program.  
5. Enter three integers when prompted.  

---

## File Contents  
- **assignment3.asm** – Main MIPS assembly source code.  

---



