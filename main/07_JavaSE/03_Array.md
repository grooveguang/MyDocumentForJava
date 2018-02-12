Array
====
##
### [返回JavaSE目录](./JavaSEDirectory.md) [回到首页目录](/README.md)


## 数组的特点和好处

### 数组的概念

数组：用于保存一组数的容器


### 数组的好处

1、减少代码量，提高开发效率
2、一个数组中多个空间是连续的，方便查找

### 数组的特点

	1、一个数组保存的是相同数据类型的元素，方便查找和管理
	2、数组的定义类型可以为任意类型，比如基本类型、引用类型都支持
	3、数组本身属于引用类型，遵循引用类型的存储特点
	基本类型 的元素 在栈中开辟空间
	引用类型 的元素 在堆中开辟空间，提供一个首地址，在栈中保存引用，引用中存储首地址号


	

### 数组的四要素

联想变量：

变量的三要素：
	
	数据类型
	
	变量名
	
	变量值	（一个）


数组的四要素：

	数据类型

	数组名

	数组元素（多个）

	下标：从0开始，到数组的长度-1


int[] arr = {1,2,3,4,5};

表示 下 元素：5


		
### 数组的使用细节

1、数组使用时，下标范围必须在：0——长度-1，否则报异常
ArrayIndexOutOfBoundsException 数组下标越界

2、数组可以不赋值直接使用，因为有默认值

int 0
double 0.0
char  \u0000
boolean false
String null

3、数组内部提供了一个属性（理解成一个变量）来获取数组的长度，提高代码的维护性

数组名.length

	


## 数组的使用步骤 ★

### 动态初始化
适用于： 知道值的规律

步骤一：声明并开辟长度

	类型[] 名 = new 类型[长度];

步骤二：循环赋值

```java
	for(int i=0;i<名.length;i++){
		名[i]=值;
	
	}
```

步骤三：使用

```java	
for(int i=0;i<名.length;i++){
		System.out.println(名[i]);
	
	}
```	

### 静态初始化
适用于：不知道值的规律，但声明时知道要赋的值



步骤一：声明并初始化

	类型[] 名 = new 类型[]{值，值};或
	类型[] 名 ={值，值};


步骤二：使用

```java
	for(int i=0;i<名.length;i++){
		System.out.println(名[i]);
	
	}
```

## 数组的简单使用
### 求和

```java
	int sum =0;//保存和
		
		for(int i=0;i<arr.length;i++){
			sum+=arr[i];
		}
		System.out.println(sum);

```

### 求最值

```java
	int max = arr[0];//创建一个擂台，假设第一个数最大
		

		for(int i=1;i<arr.length;i++){//循环和擂台上的数进行比较
			if(arr[i]>max)//如果某个元素>擂台上的数，则擂台上 易主
				max=arr[i];

		}
		System.out.println(max);
```

### 查找

```java
		System.out.print("请输入要查找的元素：");
		int search = input.nextInt();//2

		boolean flag =false;
		for(int i=0;i<arr.length;i++){
			if(search==arr[i]){
			
				flag=true;//插上小红旗
				break;
			}
		}

		if(!flag){
			System.out.println("没找到");
		}else{

			System.out.println("找到了");
		}
```

### 排序

```java
	for(int i=0;i<arr.length-1;i++){//i代表轮数
			//每一轮做的事情：重复比较多次，将较大的交换到后面
			/*arr[0] vs arr[1]  √
			arr[1] vs arr[2]
			...
			arr[arr.length-2]  arr[arr.length-1]
			*/
			for(int j=0;j<arr.length-1-i;j++){//j代表每一轮的比较次数
				//每一次比较
				if(arr[j]<arr[j+1]){
					int t = arr[j];
					arr[j] = arr[j+1];
					arr[j+1] = t;
				}
			}
		}
```

## 数组的复杂使用

### 数组的赋值

一、赋值方式一：

	语法：
	
	array2 = array1;
	
	特点：
	
	数组类型的赋值：赋的是一个地址号，二者共同引用一个空间，其中一个更改影响另外一个
	基本类型的赋值：赋的是一个元素内容（值），二者引用不同的空间，其中一个更改不影响另外一个


二、赋值方式二：

	语法：
	采用循环赋值
	
```java
		//1.为array2开辟空间
			array2 = new int[array1.length];
			//2.循环赋值
			for(int i=0;i<array2.length;i++){
	
				array2[i]=array1[i];//基本类型的赋值
			}
```

	特点：
		遵循基本类型的赋值特点，赋的是元素内容，其中一个更改不影响另外一个




### 数组的反转

反转方式一：找规律

	/*
	1 3 2 4 5  arr.length=6   3    5/2
	
	6 5 4 2 3  1   3
	
	交互的次数：arr.length/2
	
	arr[0] vs arr[arr.length-1]
	arr[1] vs arr[arr.length-2]
	....
	arr[arr.length/2-1]
	//代码如下：

```java
	for(int i=0;i<arr.length/2;i++){//i代表的是要交互的左边元素的下标
			//arr[i] vs arr[arr.length-1-i]

			int t = arr[i];
			arr[i] = arr[arr.length-1-i];
			arr[arr.length-1-i]=t;

		}
```

反转方式二：

	1.创建一个新数组，长度=旧数组的长度
	2.新数组的元素 = 旧数组的倒序的元素 （for循环赋值）
	3.将新数组的地址赋值给旧数组

	//代码如下：

```java
	//1.创建新数组，长度=arr.length
		int[] newArr = new int[arr.length];

		//2.对新数组赋值，arr的反转元素

		for(int i=0,j=arr.length-1;i<newArr.length;i++,j--){//新数组要赋值的下标
			newArr[i]=arr[j];
		}
		//3.数组的赋值
		arr = newArr;
```

## 二维数组

概念：二维数组理解成一维数组的组合，二维数组的每个元素类型 就是 一维数组

### 动态初始化


步骤1：声明

	类型[][] 名;


步骤2:开辟长度

	情况一：固定列数
	名 = new 类型[行数][列数];

	情况二：不固定列数
	名 = new 类型[行数][];

前两步可以合并：

	类型[][] 名 = new 类型[行数][列数];//列数可选


步骤3：赋值
	情况一：固定列数

```java
	for(int i=0;i<名.length;i++){
		for(int j=0;j<名[i].length;j++){
			名[i][j]=值;
		}
	}
```

	情况二：不固定列数

```java
	for(int i=0;i<名.length;i++){
		名[i]=new int[列数];//★
		for(int j=0;j<名[i].length;j++){
			名[i][j]=值;
		}
	}
```

步骤4：使用

```java
	for(int i=0;i<名.length;i++){
		for(int j=0;j<名[i].length;j++){
			System.out.print(名[i][j]);
		}
	}
```
	

### 静态初始化

步骤1：声明并初始化

```java
		int[][] arr= new int[][]{{1 ,3 ,5},{6,7,8,9},{1,2}};
		//或
		//int[][] arr2 = {{1 ,3 ,5},{6,7,8,9},{1,2}};
```

步骤2：使用

```java
		for(int i=0;i<arr.length;i++){
			
			
			for(int j=0;j<arr[i].length;j++){
				System.out.print(arr[i][j]+"\t");


			}
			System.out.println();

		}
```

[回到顶部](#readme)
