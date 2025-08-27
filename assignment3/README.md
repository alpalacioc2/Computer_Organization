# CDA3100 – Assignment #5  

## Project Information  
**Name:** Alejandro Caro  
**Class:** CDA 3100 – Computer Organization I  
**Assignment:** #5 – Count the Characters  
**Date:** (Insert date of submission)  

---

## Description  
This MIPS assembly program reads a string of up to **255 characters** from user input and counts the following categories:  

- Uppercase letters (A–Z)  
- Lowercase letters (a–z)  
- Digits (0–9)  
- Blanks (spaces)  

The program is written using **modular subroutines**, with the main logic handled in `countChars`, which processes the input string character by character and increments counters for each category.  

---

## Features  
- Reads a string from standard input (up to 255 characters).  
- Processes the string with a loop and subroutine call.  
- Classifies characters based on ASCII ranges.  
- Displays the total counts for:  
  - Uppercase letters  
  - Lowercase letters  
  - Digits  
  - Blanks  

---

## How to Run  

1. Copy the `.asm` file into your working directory.  
2. Open the program in **MARS** or **QtSpim** MIPS simulator.  
3. Assemble and run the program.  
4. Enter a string when prompted (up to 255 characters).  
5. View the output with the character counts.  

---

## File Contents  
- **assignment5.asm** – Main MIPS assembly source code with `main` and `countChars` subroutine.  

---


