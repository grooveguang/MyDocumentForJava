Reflection
====
##
### [返回JavaSE目录](./JavaSEDirectory.md) [回到首页目录](/README.md)


	1、反射的理解
	2、理解Class类的特点
	3、通过反射可以获取类的结构信息
		属性
		方法
		构造
		...
	4、通过反射创建类的对象  
	5、通过反射调用类的成员 
		方法
		构造
	6、通过反射观察泛型的本质
	7、动态代理模式

## 反射的理解

java中：

	正常的代码：
	
	类——new——创建对象
	
	反射：
	对象——getClass()——类




	
### 反射的好处（应用场景）

	张三：设计类A（未完成）、类B（未完成）、类C(完成)，实现了接口 Fly
		方法：fly()
		

	李四:定义方法

	没有用反射--------

```java
	public void method(Fly fly){
		if(fly instanceof 类A){

			类A a = (类A)fly;
			....
		}else if(fly instanceof 类B){

			类B a = (类B)fly;
			....
		}else	if(fly instanceof 类C){

			类C a = (类C)fly;
			....
		}
	}
```

	用到反射-----------------
	
```java
    public void method(Fly fly){

		Class clazz=fly.getClass();

		Object obj = clazz.newInstance();
	}
```

如果没有有用反射：

	编译报错！！！类A和类B不存在

静态加载：编译加载，指编译期间加载所有用到的类，如果该类不存在，则编译报错！！！

动态加载：运行加载，指运行期间才去加载用到 的类，采用了反射！！！



### Class的理解


1、自定义一个Student类，是不是一个对象？

	答：是

```java
	class Student{
	
	}
```


2、Student类属于谁的对象?

	答：Class
	There is a class named Class;

```java
class Animal{

}

class Car{

}
```

都有类名
都有属性
都有方法
都有构造

```java
class MyClass{

	public String getName(){}//获取类名
	public Field[] getFields(){}//获取所有的属性
	。。。
	
}


MyClass c = new MyClass();
c.getName()
```	

3、如何创建Class类型的对象？

	联想：创建Student类的对象
	Student s = new Student();
	
	如何创建Class类的对象？
	不可以使用new关键字，而是通过系统自动创建的！！！


4、如何获取Class类型的对象？

	通过以下三种方式：
		对象名.getClass
		类名.class
		Class.forName(全类名);



### Class类的特点

	1、Class本身就属于 java.lang包下的一个类
	2、Class的对象不是new出来的，而是加载类时，系统自动创建的，我们可以通过三种方式获取该Class的对象
	
	3、某个类的Class对象在内存中只有一份，因为类只能加载一次
	4、一个Class对象对应着 一个字节码文件
	5、某个类的对象（比如Student的对象stu）记得 自己是由哪个类生成的，也就是可以获取Class类的对象
	6、通过Class类的对象可以获取一个类完整的结构信息，如方法、属性、构造、类名、包名等

总结：

	Student stu = new Student();
	某个类的对象：stu,存储在堆中
	某个类的Class类的对象:Class c = stu.getClass();，存在方法区


## 通过反射获取类的结构信息

### 打印某个类的所有方法

```java
	public static void printMethods(String className) throws ClassNotFoundException{
		Class clazz=Class.forName(className);
		
		//1.获取所有的方法
		Method[] methods = clazz.getMethods();//获取该类以及从父类继承过来的所有public修饰的方法
		
		Method[] methods = clazz.getDeclaredMethods();//获取仅仅本类中所有的方法，不问修饰符
		
		//2.遍历所有方法
		
		for (Method method : methods) {
			//修饰符
			
			int mod = method.getModifiers();
			String modifier = Modifier.toString(mod);
			//返回类型
			String typeName = method.getReturnType().getSimpleName();
			
			//方法名
			String name = method.getName();
			
			//形参列表
			
			Class[] parameterTypes = method.getParameterTypes();
			
			StringBuilder builder = new StringBuilder();
			for(int i=0;i<parameterTypes.length;i++){
				String paraName = parameterTypes[i].getSimpleName();
				builder.append(paraName);
				if(i==parameterTypes.length-1)
					continue;
					
				builder.append(",");
			}
			
			System.out.println(modifier+"\t"+typeName+"\t"+name+"("+builder+")");
		}
	}
```
	
### 打印某个类的所有属性

```java
	public static void printFields(String className) throws ClassNotFoundException{
		Class clazz = Class.forName(className);
		
		//1.调用Class类的获取属性的方法
		Field[] fields = clazz.getFields();//获取该类以及从父类继承过来的所有public修饰的属性
		
		Field[] fields = clazz.getDeclaredFields();//仅仅获取该类中所有自定义的属性，不问修饰符
		
		//2.遍历所有属性
		
		for (Field field : fields) {
			//修饰符
			int mod = field.getModifiers();
			
			String modifiers = Modifier.toString(mod);
			
			//类型
			String typeName = field.getType().getSimpleName();
			//属性名
			String name = field.getName();
			
			System.out.println(modifiers+"\t"+typeName+"\t"+name);
			
		}
		
	}
```

### 打印某个类的所有构造

```java
	public static void printConstructors(String className) throws ClassNotFoundException{
		Class clazz=Class.forName(className);
		//1.获取所有构造
		clazz.getConstructors();
		Constructor[] constructors = clazz.getDeclaredConstructors();
		
		//2.遍历所有构造
		
		for (Constructor constructor : constructors) {
			//修饰符
			
			String modifier = Modifier.toString(constructor.getModifiers());
			//构造名
			
			String simpleName = clazz.getSimpleName();
			
			
			//(参数，参数)
			Class[] parameterTypes = constructor.getParameterTypes();
			StringBuilder builder = new StringBuilder();
			for (int i = 0; i < parameterTypes.length; i++) {
				builder.append(parameterTypes[i].getSimpleName());
				if (i==parameterTypes.length-1) {
					continue;
				}
				builder.append(",");
			}
			
			
			System.out.println(modifier+"\t"+simpleName+"("+builder+")");
			
		}
```

## 通过反射访问成员变量

```java
	//1.获取指定类的 类类型
		
		Class c = Person.class;
		
		
		//2.获取指定属性
		
		try {
			//Field field = c.getField("name");//只能获取公共的属性，包含从父类继承的
			Field field = c.getDeclaredField("height");//获取自定义的属性，不问修饰符
			
			//设置此属性可以被访问——暴力破解
			field.setAccessible(true);
			
			//3.获取 Person类的对象
			
			Person person = (Person) c.newInstance();
			
			
			Person person1=(Person) c.newInstance();
			
			//4.为当前person对象赋值
			
			
//			field.set(person, "张无忌");
			
			field.set(null, 190);
			
			
			//5.打印该属性的值
			
			System.out.println(field.get(person));
			
			System.out.println(field.get(person1));
			
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
```

## 通过反射访问方法

```java
	//1.获取某个指定类的类类型
		
		Class c = Person.class;
		
		
		//2.获取指定的方法
		
	//	c.getMethod(name, parameterTypes);//获取公共的方法，包含从父类继承的
		
		try {
					
			Method method = c.getDeclaredMethod("run",String.class);//获取自定义的方法，不问修饰符		
			
			method.setAccessible(true);//暴力破解
			
			//3.获取对象
			
			Person person = (Person) c.newInstance();
					
			//4. 调用方法
					
			Object invoke = method.invoke(person,"小丽");
			
			System.out.println("返回值："+invoke);
		} catch (Exception e) {
			e.printStackTrace();
		}
```

## 通过反射访问静态方法

```java
	//1.获取某个指定类的类类型
		
		Class c = Person.class;
		
		
		//2. 获取指定的方法
		
		Method method = c.getDeclaredMethod("play");
		
		method.setAccessible(true);
		
		//3.调用方法
		
		method.invoke(null);
```

[回到顶部](#readme)