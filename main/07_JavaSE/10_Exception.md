Exception
====
##
### [返回JavaSE目录](./JavaSEDirectory.md) [回到首页目录](/README.md)


	1、异常的概念
	2、异常的体系图 ★
	3、异常处理的分类★
	4、认识常见的异常
	5、自定义异常【了解】
	6、【面试题】throws和throw的区别★

## 异常的概念

	异常：运行时发生的不正常现象就称为异常
	和编译错误区分开


## 异常体系图 ★



## 异常处理和分类

	异常处理：处理运行时发生的不正常
	
	异常处理的两种方式：
	
	1、自己处理
	
	2、交给他人处理

### 自己处理

一、语法

	try{
		//①
		//有可能出现异常的代码块
		//②
	
	
	}catch(异常类型 名){
	
		//处理语句
		//③
		
	}


二、执行顺序

	如果出现了异常，① ③
	如果没出现异常，① ②
	

三、处理的方式

	处理方式一：友好提示，提高用户体验
				System.out.println("不用担心，这仅仅是小问题");
	
	处理方式二：显示错误信息
				System.out.println("出错了，错误是："+e.getMessage());
	
	处理方式三：
				e.printStackTrace();


四、语法注意事项

	1、添加finally代码块，里面放最后一定要执行的语句
	2、catch可以省略
	3、catch可以有多个，如果catch后是父类类型，一定要放在最后，否则编译报错！！！


案例：
```java
			public static int method(){
			try{
				String[] names=new String[3];
	
				if (names[1].equals("john")) {
					System.out.println(names[1]);
				} else {
					names[3]="lucy";
				}
				return 1;
			}catch(ArrayIndexOutOfBoundsException e){
				return 2;
				
			}catch(NullPointerException e){
				return 3;
			}
			finally{
	//			return 4;
			}
		}
```
	


### 交给他人处理

	
一、语法

	在容易出现异常的代码所在的方法声明处，添加抛出语句
	
	public static void method1() 	throws 异常类型或父类异常类型{

	}

	注意：

	不断抛给调用方，如果抛到main方法，main方法如果继续还往上抛，则交给虚拟机，虚拟机必须处理，处理访问为：打印错误堆栈追踪日志


二、子类重写父类的方法时，抛出类型的说明

	要求：子类重写方法的抛出类型和父类抛出的类型可以相同或为子类类型


示例：

		class Father{
		
		public void show() throws RuntimeException{
			
		}
	}
	
	class Son extends Father{
		@Override
		public void show() throws NullPointerException {
			
		}
	}



## 异常的体会

好处：

	1.提高用户体验
	2.将正常代码和错误处理代码实现了分离，提高了代码的维护性

使用注意：

	1、尽量将容易出异常的代码放在try块，而不是任意代码放在try块，提高性能
	2、尽量使用多个catch块代替 ，多个try catch
	

	

## 自定义异常

### 步骤

	1、定义class，起名 XXException，继承RuntimeException或Exception
	注意：
	继承Exception，相当于是编译异常
	继承RuntimeException，相当于是运行异常
	
	2、类中添加无参构造和有参构造

示例：
```java
	/*
	 * 自定义异常
	 */
	class AgeIllegalException extends RuntimeException {
		/**
		 * 
		 */
		private static final long serialVersionUID = 1L;
	
		public AgeIllegalException() {
	
		}
	
		public AgeIllegalException(String message) {
			super(message);
	
		}
	
	}
```

### 如何生成异常对象

	throw new XXException(“错误信息”);
	注意：如果是编译异常，必须处理！！！


### 生成异常对象的方式

	1、手动生成
		throw new XXException(“错误信息”);
	2、自动生成
		限于系统早就定义好的异常类型
		



### 常见的运行异常

	1.NullPointerException
		当妄图使用对象的属性、方法等时，但该对象为null
	2.IndexOutOfBoundsException
		ArrayIndexOutOfBoundsException
		StringIndexOutOfBoundsException
		
		当下标 不在：0——长度-1 范围 时

	3.ArithmeticException
		当除数为0时
	4.ClassCastException
		当试图强转一个不是该类型的实例时
	5.NumberFormatException
		当试图将不是有效数值的字符串转换成数值型时

## 异常中使用到的关键字

	try
	catch
	finally
	throws
	throw


【面试题】throw和throws的区别
	
				功能					定义的位置		后面跟的是什么
	throw		生成异常对象			方法体内			异常对象
	
	throws		异常处理的一种方式		方法声明处		异常类型


[回到顶部](#readme)
