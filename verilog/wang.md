模块使用说明：

## ROM

用于存储指令，根据给出的地址给出指令，不需要使用触发输出

### 接口定义

addr: 宽度为10，输入的地址

data: 宽度为32，输出的指令数据

## RgeFile

MIPS寄存器文件，用于数据的CPU内存储

### 接口定义

RA1: 宽度5，读数据的寄存器地址1

RA2: 宽度5，读数据的地址2

WA: 宽度5，写入数据的地址

Din: 宽度32，要写入的数据

WE: 宽度1，写使能，为1时可写入

clk: 宽度1，时钟信号，上升沿有效

R1: 宽度32，RA1地址处的数据

R2: 宽度32，RA2地址处的数据

## ControlSignal

基本控制信号生成，不包括拓展的指令

### 接口定义

op: 宽度6，op字段

func: 宽度6，func字段

MemToReg，MemWrite，ALU_SRC，RegWrite，SysCall，SingnedExt，RegDst，Beq，Bne，JR，JMP，JAL：
和ppt上的信号定义相同，由于拓展指令的关系有些信号的可能需要更新一下真值表，请每个人使用自己的真值表。
