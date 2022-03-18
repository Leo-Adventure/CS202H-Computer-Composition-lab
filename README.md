# CS202H-Computer-Composition-lab
The class is CS202H lectured by the computer science and engineering constitude from Sustech.

This repository contains some important lab codes, the language is assembly language, just go deep into it and start learning MIPS .

Now it has been updated to lab 5 and homewor

## Lab1
An overview of assembly language

## Lab2
Load and store data between register and memory.

## Lab3
The data details and some logistic operation in MIPS.

## Lab5

### The process of calling a procedure

In caller

- Save caller-saved registers
- Pass arguments

In callee

- Decrease the stack pointer($sp) to allocate memory
- Save callee-saved registers in the frame
  - If the value of $s0 \$s7 and \$ra will be alterd, the callee must save them
  - Register $ra only need to be saved if the callee itself makes a call
- Before returning to caller, the callee should restore all callee-saved registers and pop the stack by adding the frame size to $sp
- Then return to $ra

### Local label vs External label

#### .extern

declare label as  `.extern`, then the label is a global label, and it can be seen by other files. Otherwise, it is a local label, which can only be seen in current file.

For example:

```assembly
.extern default_str 20 # The space for default_str is 20 and it is a globla label
.data 
	default_str: .ascii "It is the default_str" # It is a local label
```



#### .globl main

The entrance of your program will be set to the location of global main

It is worth noting that you cannot define two labels that have the same name.

When there are many file assembled together, the beginning of program will locate at global main.



When declaring a label to be global, then the label can be seen by other files assembled together.

## Assignment

Converse the decimal number to binary number and hexadecimal number

And determind whether it is binary palindrome or hexadecimal palindrome.

More detail can be seen from directory `src/homework_code` and `requirement`



