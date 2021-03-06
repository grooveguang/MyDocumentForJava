


## 类型和值

Lua中有8个基本类型分别为：`nil`、`boolean`、`number`、`string`、`userdata`、`function`、`thread` 和 `table`。函数type可以测试类型。

### _nil_
Lua 中特殊的类型，他只有一个值：nil；一个全局变量没有被赋值以前默认值为 nil；给全局变量负 nil 可以删除该变量。

### _Booleans_
两个取值 false 和 true。但要注意 Lua 中所有的值都可以作为条件。在控制结构的条件中除了 false 和 nil 为假，其他值都为真。所以 Lua 认为 0 和空串都是真。

### _Numbers_
表示实数，Lua 中没有整数。Lua的 numbers 可以处理任何长整数不用担心误差。

### _Numbers_
指字符的序列。lua 是 8 位字节，所以字符串可以包含任何数值字符，包括嵌入的 0。这意味着你可以存储任意的二进制数据在一个字符串里。Lua 中字符串是不可以修改的，你可以创建一个新的变量存放你要的字符串

### _Functions_
函数是第一类值（和其他变量相同），意味着函数可以存储在变量中，可以作为函数的参数，也可以作为函数的返回值。

Lua 可以调用 lua 或者 C 实现的函数，Lua 所有标准库都是用 C 实现的。标准库包括 string 库、table 库、I/O 库、OS 库、算术库、debug 库。

### _Userdate_
userdata 可以将 C 数据存放在 Lua 变量中，userdata 在 Lua 中除了赋值和相等比较外没有预定义的操作。userdata 用来描述应用程序或者使用 C 实现的库创建的新类型。例如：用标准 I/O 库来描述文件。

### _Threads_
Lua不支持真正的多线程，而是一种协作式的多线程，彼此之间协作完成，并不是抢占完成任务，由于这种协作式的线程，因此可以避免由不可预知的线程切换所带来的问题；另一方面，Lua的多个状态之间不共享内存，这样便为Lua中的并发操作提供了良好的基础。

[内容来源](https://www.cnblogs.com/ring1992/p/6003839.html)


## 表达式

Lua 中的表达式包括数字常量、字符串常量、变量、一元和二元运算符、函数调用。还可以是非传统的函数定义和表构造。


## 基本语法

## 函数

## 迭代器与泛型for

## 编译、运行、错误信息

## 协同程序