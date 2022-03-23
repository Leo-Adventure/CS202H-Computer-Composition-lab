# CS202H-Computer-Composition-lab
The class is CS202H lectured by the computer science and engineering constitude from Sustech.

This repository contains some important lab codes, the language is assembly language, just go deep into it and start learning MIPS .

Now it has been updated to **lab 6 and homework 1**

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

## Lab6

#### Exception and interruption

An exception is an event that disrupts the normal flow of the execution of your code

- Accessing to the 0x0 address in user mode will trigger an exception!!!
- The CPU will figure out what is wrong by checking its status, see if it can be corrected and then continue the execution of the normal code like nothing happened, or it stops  the code execution

And interruption is an event caused by a device which is external to the CPU

- "syscall" is an interruption

#### Common Exception

##### Arithmatic type

- Overflow exceptions, which occur when arithmetic operation compute **signed** values and the destination lacks the precision to store the result.

- Divide-by-zero exceptions

##### Address error

- memory alignment
- invalid address accessing

```assembly
.data
	ws: .word 2:10 # apply for 10 words, each word will be initialized to 2
```

#### How MIPS Acts When Taking An Exception

1. setting up EPC to point to the restart location, record the address, if the accident isn's so serious, the program can still go back to the address  and continue running.
2. CPU changes into kernel mode and disables the interrupts(MIPS does this by setting EXL bit of Status register)
3. Set up the Cause register to indicate which is wrong.
4. CPU starts fetching instruction from the exception entry point and then goes to the exception handler.

##### Related instructions

- Conditional trap

  - ```assembly
    teq $s0, $s1
    tne $s0, $s1
    teqi $s0, 1
    ```

  - ```assembly
    mfc0 $k0, $14 ## MOVE FROM coproc0  reg$14
    mtc0 $k0, $14
    ```

The entrance address of exception handler is 0x80000180

