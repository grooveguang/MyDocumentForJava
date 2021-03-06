Static Finally
====
##
### [返回JavaSE目录](./JavaSEDirectory.md) [回到首页目录](/README.md)


	1、static关键字
	2、final关键字
	3、初始化块
	4、单例设计模式


## static关键字

### static关键字的概念

static 属于一种修饰符，可以用于修饰** 属性、方法**、内部类、初始化块，不能修饰构造器和局部变量

### static修饰成员

	1、用static修饰的成员，称为静态成员，或类成员
	2、静态成员都和对象无关
	3、都随着类的加载而加载，而且都加载一次

### 静态属性的特点

	  1、static修饰的属性称为静态属性也称为类属性，和对象无关
	    没有用static修饰的属性称为普通属性也称为实例变量
	  2、生命周期不同：
	  		静态属性随着类的加载而加载，随着类的消亡而消亡
	     	普通属性随着对象的创建而加载，随着对象的消亡而消亡
	  3、存储位置不同：
	  		静态属性存在方法区中，而且只有一份
	  		普通属性存在堆中，有多少个对象就有多少个普通属性的空间
	  4、静态属性被所有对象所共享  ★，其中一个对象对其进行更改，影响另外的
	    普通属性 被每个对象所独享，对象和对象的属性是独立的，互不影响
	  5、静态属性由于和对象无关，所以建议用类名直接调用
	    语法：类名.属性=值;
	    
	    总结：
	    静态属性的调用方式：
	    		对象名.属性=值;不建议
	    		类名.属性=值;推荐使用
	    普通属性的调用方式：
	    		对象名.属性=值;
	    
	  6、什么时候需要使用静态属性？
	  当多个对象的该属性值一样
	  如：国家、圆周率、利率等

### 静态方法的特点

	   1.用static修饰的方法称为静态方法或类方法，没有用static修饰的方法称为普通方法或实例方法
	   2.静态方法和普通方法都随着类的加载加载进方法区，存储的都是方法描述信息，只有被调用时，才执行方法入栈
	    区别：
	    静态方法中，不需要传入当前对象，则可以调用
	    普通方法中，必须传入当前对象，才能调用（this引用是系统默认传入的，不用手动传入）
	    
	   3、调用方式不同：
	   	静态方法：
	   		类名.方法名();
	   		对象名.方法名();不建议
	   
	   	普通方法：
	   		对象名.方法名();
	   4、静态方法中 只能直接访问静态的成员（静态属性和静态方法），原因：普通成员必须通过对象才能访问，而静态方法中没有隐含的对象
	     普通方法中 可以调用任意成员，包含普通成员和普通方法，原因：普通方法中有隐含的对象 this
	     
	   5、当方法中不涉及到任何和对象有关的成员时，则可以将方法设计成静态，因为静态方法调用比较简单
	   
	   一般工具类中的工具方法设计成静态
	   比如：Math类、Arrays类等

## final关键字

### 概念

final 可以修饰 类、属性、方法、局部变量，不能修饰构造器、初始化块


### final修饰类

final修饰类，代表该类不能被继承，也称为 太监类

比如：String类就是final修饰的

### final修饰方法

final修饰方法，代表该方法不能被重写，可以被继承



### final修饰变量（属性和局部变量）

	final修饰变量，代表该变量变成了常量，值不能再更改！！！
	
	final 类型 名 = 值;
	
	
	注意：
	
	1、final修饰属性时，必须初始化，可以在以下场合初始化
		没有用static修饰的 常量属性：
			声明时初始化
			构造器初始化
			初始化块初始化
		
		用static修饰的  常量属性：
		
			声明时初始化
			静态初始化块初始化
	
	
	2、全局常量，一般遵循全大写的命名规范，提高代码的阅读性
	
	3、全局常量，往往和static关键字搭配使用
	
	4、常量的类型如果为引用类型，可以更改对象的属性，不能更改该引用指向的对象（地址）



## 初始化块

### 概念

	初始化块又称为代码块，属于类中第四个成员。类似于方法，没有方法名，没有参数，没有返回，只有方法体，不是通过类或对象显式的调用，都是通过创建类或创建对象时隐式调用
	
	类的成员：属性、方法、构造、初始化块、内部类

### 语法

	[修饰符]{
	
		//执行语句
	
	}

	1、修饰符只能是static
	2、用static修饰的初始化块称为静态初始化块，没有用static修饰的初始化块称为普通初始化块
	3、初始化块里面可以有输出语句、输入、分支等语句

### 好处

	1.和构造器类似，初始化信息
	2.当一个类中出现了构造器重载，而且构造器中有重复的语句，这个时候往往将重复语句提取到初始化块中，提高代码的重用性


## 初始化块的特点

	1、 静态初始化块 当加载类时则会执行
	    普通初始化块 当对象创建时自动执行
	
	  加载类的时机：
		① 第一次new对象
		②调用类的静态成员
		③ 当加载子类时，父类也会加载
	
	2、一个类中可以有多个普通初始化块，也可以有多个静态初始化
		执行顺序：静态>  普通
		对于同类型的初始化块，取决于定义的先后顺序
	
	3、静态初始化块|静态属性 >  普通属性|普通初始化块 > 构造器
		【同类型的初始化块和属性的先后顺序取决于定义的先后顺序】
	
	4、当具有父子类时
	
		父类的静态初始化块|父类静态属性 > 子类静态初始化块|子类静态属性>
		
		父类的普通属性|普通初始化块>父类构造器>子类 普通属性|普通初始化块>子类构造器
	
		【同类型的初始化块和属性的先后顺序取决于定义的先后顺序】
		
	
	5、静态初始化块随着类的加载而加载，不管创建多少个对象，只执行一次
	   普通初始化块随着对象的加载而加载，有多少个对象，就执行多少次
	
	6、静态初始化块 具有静态成员遵循的所有特点，里面也是只能访问静态成员
	


## 单例设计模式

### 单例设计模式解决什么问题？

	希望某个项目  只存在某个类的一个实例

### 为什么需要解决这个问题

	1、为了业务需要
	2、需要频繁的调用某个类的方法，如果频繁创建对象会导致资源浪费和效率的降低


### 如何解决 ？★

	1.构造器私有化
	2.在类的内部创建对象
	3.提供一个公共的静态的方法，向外暴露该对象即可


### 单例设计模式的使用★

	1、饿汉式

```java
	class Single{
		private static Single s = new Single();
		private Single(){

		}

		public static Single getInstance(){

			return s;
		}

	}
```

	2、懒汉式

```java
	class Single{
		private static Single s;
		private Single(){

		}

		public static Single getInstance(){
			if(s==null)
				s = new Single();
			return s;
		}

	}
```

	二者的区别：创建的对象的时机不同，饿汉式创建较早！！！

[回到顶部](#readme)
	



	
	
















