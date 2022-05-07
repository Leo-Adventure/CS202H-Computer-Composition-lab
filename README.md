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

##  复习

### 计组易错点

#### Chapter 1

- CPU 性能 = CPI * #指令 * 时钟周期
- 响应时间：计算机完成某任务所需的总时间
- 吞吐率：单位时间内完成的任务数量

#### Chapter 2

- 在书写汇编语言的时候需要注意MIPS是按照字节进行编址的，而一个寄存器可以容纳 4 个字节，所以计算数组偏移量的时候需要 * 4
- 二进制补码的英文是 two's complement，二进制反码的英文是 one's complement
- MIPS 字段 ：

**R 型**

op (6 bit) 操作码 + rs (5 bit) 第一个源操作数寄存器 + rt (5 bit) 第二个源操作数寄存器 + rd (5 bit) 存放操作结果的寄存器 + shamt (5 bit) 位移量 + funct (6 bit) 功能码

**I 型 (立即数 、数据传送 、条件分支指令 )**

op (6 bit) 操作码 + rs (5 bit) 第一个源操作数寄存器 + rt (5 bit) 第二个源操作数寄存器  + const  or address (16 bit)

**J 型（跳转指令）**

op (6 bit) 操作码 + addr (26 bit) 地址

在存取字指令中，rt 字段用于指明接收取数结果的**目的寄存器**，rs 字段用于指明 **基址寄存器**

- 栈增长是按照地址从高到低的顺序进行的，比如要存入三个临时变量，则

  ```assembly
  addi $sp, $sp, -12
  sw $t1, 8($sp)
  sw $t0, 4($sp)
  sw $s0, 0($sp)
  ```

  返回的时候：

  ```assembly
  lw $s0, 0($sp)
  lw $t0, 4($sp)
  lw $t1, 8($sp)
  addi $sp, $sp, 12
  ```

- 递归程序写法

```cpp
int fact(int n){
    if(n < 1) return 1;
    else{
        return n * fact(n - 1);
    }
}
```

汇编语言：

```assembly
fact:
	addi $sp, $sp, -8
	sw $ra, 4($sp) # 保留调用 fact 的地址
	sw $a0, 0($sp) # 保留 n
slti $t0, $a0, 1 # 判断 n !< 1
beq $t0, $zero, L1

addi $v0, $zero, 1 # return 1
addi $sp, $sp, 8 # 恢复栈空间，由于 n < 1 时，没有改变 $ra 和 $a0 的值，所以不进行加载
jr $ra # 回到调用地址

L1:
	addi $a0, $a0, -1 # 将 n - 1 作为新参数
	jal fact # 重新调用 fact, 并将 $ra 设置成下一条指令

lw $a0, 0($sp)
lw $ra, 4($sp)
addi $sp, $sp, 8

mul $v0, $a0, $v0
jr $ra
	
```

- 使用 $lui$ 和 $ori$ 将**32**位常量加载到寄存器 $\$s0$ 
- PC 相对寻址是相对于**下一条指令**的地址（PC + 4），将PC 和 指令中的常数相加作为寻址结果，并且由于所有的 MIPS 指令都是 4 字节长，所以在PC 相对寻址时所加的子式被设计为字地址而不是字节地址，这样对于 条件分支指令 就可以使用 16 位 来表示18位的字节地址，对于跳转指令就可以使用 26 位来表示 28位的字节地址。 -> 这样，通过计算得到的目标地址就是  **PC + 4 + const * 4**； 并且由于 PC 是 32 位，高四位保持不变，跳转指令中的常数 代替 PC 的低 28 位。
- 条件分支指令是相对于下一条 PC 地址的寻址。跳转指令是采用完整的地址进行寻址，例如 需要跳转到 80000 地址，对应的跳转指令的 常数字段 填写 20000， 因为 20000 * 4 = 80000.

- sll \$t1, \$s3, 2 的机器码表示，由于 rs 是空的，所以置零，  -> 0 0 19 9 2 0
- R 型指令的操作码是 0

#### Chapter3

- 除法 乘法 硬件实现以及改进
- 偏阶为 $2^{s-1} - 1$
- 注意指数 = s - 偏阶，尾数 = 1 + frac
- 浮点加法
  - 将有较小指数的数向有较大指数的数对齐
  - 将有效位相加
  - 调整至规格化表达
  - 舍入
- 指数全零和全1 都被保留

#### Chapter 4

- 除了跳转指令之外的指令（存储访问、算术逻辑、分支）在读取寄存器之后都会使用 ALU
- 数据通路功能部件包括两个逻辑单元：处理数据值的**组合单元** 和 存储状态的 **状态单元**
- **边沿触发方法**支持状态单元在同一个时钟周期内同时读写而不会因为竞争而出现中间数据。
- 存储器需要读控制信号，寄存器则不需要；PC不需要写控制信号，因为每个周期都会进行写入。
- RegDst 为 1 时，控制 写入寄存器编号字段 来自 rd 而不是 rt
- 跳转指令的实现：[当前 PC + 4 的 高 4 位 : 跳转指令的 26 位立即数字段 ：低位 00]
- 流水线带来的性能提高是 **增加指令的吞吐率**
- 结构冒险：缺乏硬件支持导致指令不能在预定的时钟周期内执行的情况
- 数据冒险：无法提供指令执行所需数据而导致指令不能再预定的时钟周期内执行的情况 -> 解决办法： forwarding / bypassing.
- 控制冒险：取到的指令不是所需要的，导致指令不能在预定的时钟周期内执行 ---> 解决办法：分支预测
- 在 EX，MEM，和 WB 级如果将所有 9 个控制信号全部清除（置零），就会产生一个空指令，相当于在流水线插入气泡，事实上只需要将 MemWrite 和 RegWrite 置零即可
- 动态分支预测：通过查找指令的地址观察上一次执行该指令时分支是否发生，如果上次执行时分支发生，就从上一次分支发生的地方开始取新的指令。一种实现方法是：分支预测缓存（branch prediction buffer）
- 增加指令集并行的两种方式：增加流水线的深度 & 多发射（multiple issue）
- 发射包（issue packet）可以由编译器静态生成，也可由处理器动态生成，是在一个时钟周期内发射的多条指令的集合
- 循环展开（loop unrolling）：一种从存取数组的循环中获取更多性能的技术
- 寄存器重命名：由编译器或硬件对寄存器进行重命名以消除反相关
- 动态流水线调度：对指令进行重排序以避免阻塞的硬件支持
- 乱序执行（out-of-order commit）：执行的指令被阻塞时不会导致后面的指令等待
- 静态——编译器（软件）；动态——处理器（硬件）



