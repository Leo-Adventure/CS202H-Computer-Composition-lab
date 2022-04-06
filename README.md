# CS202H-Computer-Composition-lab

[TOC]

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

## Lab7 Floating-Point number

#### IEEE 745

signal bit : 0 represents positive and 1 represents negative

exponent: (yyyy + Bias) (float for 8 bits and double for 11 bits) **(0000_0000 and 1111_1111 are reserved for special value, so the range is  from 0000_0001 to 1111_1110**

bias: the half during the minimum 0000_0000 and 1111_1111, which is 0111_1111——$2^{n - 1} -1$

fraction: float for 23 bits and double for 52 bit

**declaration**

```assembly
.data
fneg1: .float -1 # s: 1, exp: 0 + 0111_1111; fraction: 0
fpos1: .float 1
```

**Infinite and NaN**

when the exponent is all 1. If the fraction is all 0, the value depends on the signal, when the signal is 1, the value is positve infinite, when the signal is 0, the value is negative infinite. If the fraction is not all 0, the valure is NaN

Any operation on NaN will produce NaN

#### load and store float data

**Attention**, when loading and storing double data, the index of floating register should be evened number.

```assembly
ldc1 $f0, fneg1 # load the double floating data from fneg1 to coproc 1
ldx1 $f1, fpos1
add.d $f11, $f0, $f2

lwc1 $f0, fneg1 # load the single precision data from fneg1 to coproc 1
swc1 $f0, ...
```

#### Relational

Compare two floating-point values and set conditional flag

```assembly
c.eq.s
c.eq.d
```

#### Conditional jump

 ```assembly
 bc1t 7, print # if the conditional flag 7 is true, then jump to print
 bc1f 1, exit # if the conditional flag 1 is false, then jump to exit
 ```

## Lab8 Verilog

To generate bitstream, we should have:

- design.v
- constraint file(xci)
- project-device

Design-Under-Test vs Test Bench

Structured design (top module, instance module)

Block( Combinational, Sequential)

**reg and wire**

- 除非要求用reg，否则都是使用wire
- 必须用reg 的情况：initial 以及 always 被赋值的对象必须是reg
