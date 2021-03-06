Multi Threading
====
##
### [返回JavaSE目录](./JavaSEDirectory.md) [回到首页目录](/README.md)

	1、线程的相关概念
	2、如何创建和启动线程 ★
	3、创建线程两种方式的对比 ★
	4、线程的停止（死亡）
	5、线程的常见方法
	6、线程的生命周期★
	7、线程的同步
		单例模式
		死锁
	8、线程的通信


## 线程的相关概念

	程序：为了让计算机实现某个功能，而编写的一系列有序指令的集合，实际上就是一段静止的代码
	
	进程：正在运行的程序，它是“活”的，有自己的生命周期
		举例：正在运行的qq，正在运行的office软件
	
	线程：一个进程中可以划分为多个 子任务，每个子任务称为“线程”
		一个进程有多个线程组成
	
	
	多任务：
		多进程：同一个时刻，允许多个进程“同时”执行
		多线程：同一个时刻，运行多个线程“同时”执行


备注：

		貌似“同时”：
	
		多个任务不断切换cpu的时间片，切换的频率非常快，给我们造成了一种“同时”的错觉
	
		window属于多任务（多进程）操作系统
		java中支持多线程


## 多线程的好处

	1、有效的利用了cPU的空闲时间，从某种意义上来讲，提高了效率
	2、提高了用户的体验


## 多线程的应用场景

	1、程序中同时执行多个任务
	2、程序中涉及到了耗时操作，比如下载、用户输入等
	3、需要后台完成一些事情



## 线程的创建和启动

### 方式一：

	1、定义类A继承Thread，重写run方法
	2、A a =new A();
		a.start();


### 方式二：

	1、定义类A 实现Runnable接口，重写run方法
	2、 A a = new A();
		new Thread(a).start();

### 相同点

	1、都是将任务体放在run方法
	2、都是通过Thread类的start方法启动线程


###不同点

	1、使用方式二，可以避免单继承的局限性
	2、如果多线程有共享数据资源，建议大家使用方式二

## 线程的停止

注意：不建议使用Thread类的stop方法，因为已经过时，而是采用标记的方式

步骤：

	1、循环的条件使用一个boolean变量loop
	2、loop默认值为true
	3、添加一个公共的更新loop的方法

```java
	public void setLoop(boolean loop){

		this.loop=loop;
	}
```

	4、需要停止线程时，调用setLoop方法，传入false即可


## 线程的常见方法

	currentThread():获取当前线程对象，里面默认包含线程名、优先级、线程组
	toString():线程重写了toString
	setName():设置线程名称
	getName():获取线程名称
	start():启动线程，并调用run方法
	run()：线程的任务体
	setPriority():设置优先级 ，级别：1——10，默认为5  
				MIN_PRIORITY	MAX_PRIORITY	NORM_PRIORITY
	getPriority():获取优先级
	sleep():休眠指定时间
	interrupt（）:中断线程
	yield():线程的礼让
	join():线程的插队
	setDaemon():设置守护线程


	
## 线程的生命周期

			阻塞

	新建——就绪——运行——死亡

	

## 线程的同步

### 线程的同步的问题引入

	原因：其中一个线程在执行时，被其他线程中途插入，导致数据出现了脏读
	
### 如何解决

	让一个线程执行过程中，其他线程不允许参与，只有当该线程执行结束，其他线程才能进入

参考：火车厢上厕所的例子，通过上锁的方式

### java如何实现同步

	1、同步代码块
	
	synchronized(对象){
		需要同步的代码
	}	
	
	2、同步方法
	
	修饰符 synchronized 返回类型 方法名(){
	
		需要同步的代码
	}
	
	注意：同步方法的默认锁对象为this


### 一般什么情况下才会出现同步的问题（同步的前提）

	1.多线程
	2.多线程需要有共享数据


### 实现同步的步骤★
	
	1、分析得出需要同步的代码
	2、选择同步代码块或同步方法
	3、选择锁对象（一定要保证 多线程使用的锁对象为同一个）!!!
	一般选：this



## 线程的通信

### 线程通信的理解

	线程和线程之间可以“对话”，可以控制线程的执行

	wait()
	notify()
	notifyAll()

	
	

### wait、notify、notifyAll方法的理解

wait：
	意思：让当前线程等待
	语法：当前线程的锁对象.wait();

	必要条件：
		1、必须在同步前提下
		2、同步的锁对象和wait的调用者是同一个

	特点：
		1、调用wait方法后，该线程会释放锁
		2、只有当同一个锁下其他线程调用了notify或notifyAll，才有可能唤醒wait的线程，重新让该线程进入就绪状态

notify|notifyAll：

	意思：唤醒同一个锁下的其他正在等待的线程
	语法：当前线程的锁对象.notify();
	
	必要条件：
		1、必须在同步前提下
		2、同步的锁对象和wait的调用者是同一个

	特点：
		1、唤醒的是当前锁下，调用了wait的线程，优先唤醒的是优先级高的线程


### 线程通信的前提

	1、同步的前提下
		（多线程+有共享数据）
	2、使用wait或notify进行控

[回到顶部](#readme)





	


	