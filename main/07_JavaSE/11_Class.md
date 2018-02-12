Class
====
##
### [返回JavaSE目录](./JavaSEDirectory.md) [回到首页目录](/README.md)


	包装类 ☆
	String类 ★
	StringBuffer类和StringBuilder类 ☆
	Math类
	Date类
	Calendar类
	BigInteger类	
	BigDecimal类
	System类
	


## 包装类

### 包装类的概念

java中分为两大数据类型：

基本类型

引用类型

包装类的概念：八大基本数据类型的一一对应的引用类型
包装类出现的意义：相当于基本类型也有了方法

int 10
Integer 10


### 认识包装类 ★

	byte——————Byte
	short————Short
	int——————Integer ★
	long—————Long
	
	float————Float
	double———Double
	
	char—————Character ★
	boolean———Boolean


### 包装类和基本类型之间的转换  ★

★ 注意：所有包装类都支持下列的转换


一、手动装箱和手动拆箱

	一）手动装箱
			int i1=10;//基本类型
			//方式一：通过构造器
			Integer i2 = new Integer(i1);//包装类型
			//方式二：通过静态方法
			Integer i2 = Integer.valueOf(i1);
	
	二）手动拆箱
			int i3 = i2.intValue();

二、自动装箱和自动拆箱  ★

jdk5.0出现的新特性

	一）自动装箱
			int i1=10;//基本类型
			
			Integer i2 = i1;
	
	二）自动拆箱
			int i3 = i2;

### 包装类和String类型的转换

一、包装类型——>String
		
		Integer  i1 = new  Integer(100);
		//方式一：拼接一个空字符串
		String s = i1+"";
		//方式二：调用toString
		String s = i1.toString();
		
二、String——>包装类

		String s1 = "1234";
		
		//方式一
		Integer a = new Integer(s1);
		
		//方式二
		Integer b = Integer.valueOf(s1);


### 基本类型和String类型的转换

一、基本类型————>String
		
		int m =10;
		String s = m+"";
		
		
二、String——————>基本类型

		int i =Integer.parseInt(s);
		
		
特殊案例：char

		//char————>String
		
		char ch='a';
		String str = ch+"";
		
		//String——>char
		String str1 = "hello";
		char ch1 = str1.charAt(1);

	
### Integer类的常见方法

	toBinaryString 转换成二进制
	toHexString转换成十六进制
	toOctalString 转换成八进制

### Character类的常见方法

	isLetter 判断是否为字母
	isDigit 判断是否为数字
	isUpperCase判断是否为大写
	isLowerCase判断是否为小写
	toLowerCase转换成小写
	toUpperCase转换成大写
	
	

## String类

### String类创建对象的方式

	方式一：直接赋值
	
	String s="";
	
	方式二：通过new关键字创建对象
	String s = new String("");


二者的区别：

	方式一  先去常量池中查找有无元素内容为“hello”的空间，如果没有，则创建，并通过s引用指向该空间。如果有，则直接通过s引用指向

	方式二 堆中创建一个空间，value属性指向常量池中 元素内容为“hello”的空间。
	s引用指向的是堆中的那块空间！！！

案例：

	1.String s = new String("hello");
	两个

	2.  String s1 = "hello";
		String s2 = new String("hello");
	两个

	3.String s1 = new String("hello");
	  String s2 ="hello";
	两个

	4.String s1="hello";
      String s2 ="hello"
	一个

	5.String a = "hello";
	  a="world";
	两个
	
	6.String a="AA";
	  String b="BB";
	  String c=a+b;

	 四个

	7.String a="AA";
	  String b="BB";
	  String c=a+b;
		
		c保存的实际是堆中某块空间的地址号

	  String d = c.intern();
		d保存的是常量池的地址号

	
## StringBuffer类

### StringBuffer和String类的区别

1、核心区别

	StringBuffer保存的是字符串变量，里面的值可以修改
	String保存的是字符串常量，里面的值不可以修改

2、存储位置

	StringBuffer的值存储在堆中
	String的值存储在常量池中

3、创建对象方式

	StringBuffer只能通过构造器创建对象
	String有两种创建对象的方式

4、效率

	StringBuffer每次更新字符串，不需要重新开辟空间，效率比较高
	String每次更新字符串，需要重新开辟空间，效率非常低

### StringBuffer创建对象的方式

通过调用构造器创建对象
	
	new StringBuffer();//构造一个默认容量为16的StringBuffer对象
	new StringBuffer(int capcity);//根据指定容量构造一个StringBuffer对象
	new StringBuffer(String str);//根据参数字符串构造一个StringBuffer对象

### StringBuffer和String类的转换

一、String——>StringBuffer

	1.方式一

	StringBuffer s = new StringBuffer(string);

	2.方式二

	StringBuffer s = new StringBuffer();
	s.append(string);
	

二、StringBuffer——>String

	1.方式一

	String s1 = stringBuffer.toString();

	2.方式二

	String s2 = new String(stringBuffer);

### StringBuffer类的常见方法

	append 追加任意类型
	insert 在指定位置插入任意类型
	delete 删除指定位置的内容
	replace 修改指定位置上的内容
	reverse反转
	length 获取长度
	indexOf/lastIndexOf 获取字符串第一次或最后一次出现的索引，如果找不到返回-1
	substring截取子字符串
	
### StringBuilder和StringBuffer对比

相同点：

二者都是可变字符序列，里面的方法都一样，使用方式一样

不同点：

					版本				线程安全		同步		效率
	
	StringBuffer	老（1.0）		安全			同步		较低
	
	StringBuilder	新（1.5）		不安全		不同步	较高



### String、StringBuffer、StringBuilder

	StringBuilder>StringBuffer>String


总结：

	1.String类创建对象
	2.StringBuffer和String的区别
	3.StringBuffer和StringBuilder的区别
		
	
注意：其他小类见代码

[回到顶部](#readme)
