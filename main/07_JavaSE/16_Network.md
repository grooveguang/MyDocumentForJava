Network
====
##
### [返回JavaSE目录](./JavaSEDirectory.md) [回到首页目录](/README.md)


	1、网络编程的相关概念
	2、java.net包下的InetAddress的类的学习
	3、基于TCP协议下的网络通信
	4、基于UDP协议下的网络通信
	5、基于URL的编程


## 网络编程的相关概念

一、网络编程

网络编程：程序员 通过一定的方式 实现 数据在两台或多台计算机设备的传输

	要么发送数据到指定的设备上，要么接受从其他设备传输过来的数据

	java.net包下提供了一系列的类实现网络编程

二、网络

	两台或多条计算机通过一定的物理设备连接起来，构成了网络

	

三、网络根据覆盖范围不同进行如下分类

	局域网：覆盖范围比较小，在一个教室或一个机房等

	城域网：覆盖范围比较大，覆盖一个城市

	广域网：覆盖范围最大，覆盖全国甚至全球
		互联网就是广域网的代表



四、IP地址

	概念：用于标识网络中的某台计算机设备的，相当于人 的是身份证号
	表示方法：点分十进制形式  xx.xx.xx.xx

	每一个十进制数的范围：0-255

	ip地址=网络地址+主机地址

	ip地址的分类：
		第一个十进制数的范围	网络地址		主机地址
	A	1——126				第一位		后三位
	B	128——191				前两位		后两位
	C	192——223				前三位		后一位	
	D	用作科研、测试等特殊功能
	E

	0.0.0.0  本机回环地址
	127.0.0.1 本机回环地址


五、域名

	为了方便记忆，使用域名代替ip地址

	
	类似于：

	电话簿：手机号码——联系人
		    ip地址——域名


	www.baidu.com——————ip地址
	


六、端口号

	概念：用于标识某台计算机上的唯一的网络程序
	范围：0——65535
	0——1024已经被占用了

	mysql：3306
	sqlserver：1433
	oracle：1521
	http:80
	tomcat:8080


		      ip|域名——————端口号
    类似于：	总机号———————分机号



七、通信协议

					是否需要建立连接		安全可靠		是否有数据大小限制		效率		释放连接

	基于TCP协议		√					√			×					低		需要
	
	基于UDP协议		×					×			√					高		不需要


## 基于TCP/IP的网络通信

### 服务端

//1. 创建ServerSocket对象

```java		
		ServerSocket server = new ServerSocket(8888);
			
		//2. 等待客户端请求并接受请求客户端对象
		
		Socket client = server.accept();
	
		//3.进行读写数据	
		
		//----------------------读取客户端发送过来的数据---------------------
		System.out.println("接收到了"+client.getInetAddress().getHostName()+"的数据：");
		InputStream inputStream = client.getInputStream();
	
		byte[] b=new byte[100];
		
		int len = - 1;
		while((len=inputStream.read(b))!=-1){
			System.out.print(new String(b,0,len));
			
		}
		
		//-----------------------向客户端发送数据----------------------

		//获取写入流对象
		OutputStream outputStream = client.getOutputStream();
		
		outputStream.write("地瓜你好，我收到了！！！".getBytes());
	
		client.shutdownOutput();//标识 写入结束！！！
	
		//4.关闭流和连接
		
		outputStream.close();
		inputStream.close();
		
		client.close();
		
		server.close();
```

### 客户端

```java	
	//1. 创建Socket对象，指向 具体的服务端
		Socket socket = new Socket(InetAddress.getLocalHost(),8888);
			
		//2.进行读写数据
		//-------------------写入------------------------
		OutputStream outputStream = socket.getOutputStream();
		
		outputStream.write("土豆土豆，我是地瓜，收到请回答！！！\n".getBytes());
			
		socket.shutdownOutput();//设置结束标记	
		
		//-------------------读取-------------------------
		
		//获取读取流对象
		
		InputStream inputStream = socket.getInputStream();
			
		byte[] b=  new byte[100];
		
		int len = -1;
		
		while((len=inputStream.read(b))!=-1){
			
			System.out.print(new String(b,0,len));
		}
				
		//3.关闭流和连接
	
		inputStream.close();
		outputStream.close();
		
		socket.close();
	}
```

### 案例： 发送图片案例

服务端

```java
	@Test
	public void testServer() throws Exception {		
		
		//1.创建ServerSocket对象
		ServerSocket server = new ServerSocket(9999);		
		
		//2.接受客户端		
		Socket socket = server.accept();
		
		//3.创建流对象			
		InputStream inputStream = socket.getInputStream();//此流用于读取客户端发来的图片
		
		FileOutputStream fos = new FileOutputStream("C:\\Users\\liyuting\\Desktop\\copy.jpg");//此流用于写入到本地		
		
		PrintStream writer  = new PrintStream(socket.getOutputStream());//此流用于将文本数据写入到客户端
		
		
		//4.读取客户端的图片并写入到本地	
		byte[] b = new byte[1024];
		int len = -1;
		while ((len = inputStream.read(b)) != -1) {
			fos.write(b, 0, len);
		}
		fos.close();
			
		//5.向客户端发送文本数据，代表接受成功了
		
		writer.println("接受完毕！谢谢，图片很好看");
		
		
		//6.关闭流和连接	
		inputStream.close();
		writer.close();	
		socket.close();	
		server.close();
	}
```

客户端

```java
	@Test
	public void testClient() throws Exception {

		// 1.创建Socket对象
		Socket socket = new Socket(InetAddress.getLocalHost(), 9999);

		// 2.创建流对象
		FileInputStream fis = new FileInputStream("src/xh.jpg");// 此流用于读取本地的图片

		OutputStream outputStream = socket.getOutputStream();// 此流用于写入到服务端

		BufferedReader reader = new BufferedReader(new InputStreamReader(
				socket.getInputStream()));// 此流用于读取服务端发送的文本数据

		// 3.向服务端写入图片数据
		byte[] b = new byte[1024];
		int len = -1;
		while ((len = fis.read(b)) != -1) {
			outputStream.write(b, 0, len);
		}
			
		fis.close();
		
		socket.shutdownOutput();//设置一个写入完毕的标记★

		// 读取服务端发送来的 文本数据
		String line = reader.readLine();
		System.out.println(line);// 控制台打印

		// 4.关闭
		reader.close();
		outputStream.close();
		socket.close();

	}
```

## 基于UDP的网络通信

发送方

```java
	@Test
	public void testSend() throws Exception {
		// 1. 创建接收方的套接字 对象 ，也就是DatagramSocket对象,并指定自己的端口号

		DatagramSocket se = new DatagramSocket(6666);

		// 2. 创建数据包对象，也就是 DatagramPacket对象，并指定发送的数据内容和最大长度以及 目的主机名和端口号

		/*
		 * 参数1：发送的数据 参数2：发送的实际长度 参数3：接收方的主机 参数4：接收方的端口
		 */
		byte[] buf = "你好，我打算送给你一个土豆".getBytes();
		DatagramPacket packet = new DatagramPacket(buf, buf.length,
				InetAddress.getLocalHost(), 8989);
			
		//3.  发送
		se.send(packet);	
		
		//4.关闭	
		se.close();
	}
```

接收方

```java
	@Test
	public void testReceive() throws Exception {

		// 1. 创建接收方的套接字 对象 ，也就是DatagramSocket对象,并指定端口号

		DatagramSocket rec = new DatagramSocket(8989);

		// 2. 创建数据包对象，也就是 DatagramPacket对象，并指定接受的数据内容和最大长度

		/*
		 * 参数1：接受的数据存到的数组对象 参数2：接受的最大长度
		 */
		byte[] buf = new byte[100];
		DatagramPacket packet = new DatagramPacket(buf, buf.length);

		// 3.接受
		rec.receive(packet);

		// 4.打印接收到 数据
		System.out.println("接收到了：" + packet.getSocketAddress() + "的数据，内容是："
				+ new String(buf, 0, packet.getData().length));

		// 5.关闭
		rec.close();
	}
```

## URL编程

概念：

url：同一资源定位符

uri：统一资源标识符

uri>url

### 打印服务端某文本文件内容

1.创建URL对象 ——相当于写上 网址
		
		URL  url= new URL("http://127.0.0.1:8080/StreamUtils.txt");
		
2.打开连接——相当于地址栏敲回车	
		
		URLConnection connection = url.openConnection();
		
3.获取连接中的流内容
		
		System.out.println(connection.getContentLength());
		System.out.println(new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(new Date(connection.getLastModified())));
		System.out.println(connection.getContentType());
		System.out.println("文件内容：");
		
		InputStream inputStream = connection.getInputStream();
		String content = StreamUtils.streamToString(inputStream);
		System.out.println(content);


### 下载服务端的图片文件

1.创建URL对象 ——相当于写上 网址
		
		URL  url= new URL("http://127.0.0.1:8080/ae.jpg");
		
2.打开连接——相当于地址栏敲回车

		URLConnection connection = url.openConnection();
		
3.获取连接中的流内容
		
		InputStream inputStream = connection.getInputStream();//此流用于读取连接中的图片
		
		FileOutputStream fos = new FileOutputStream("src/zhuyin.jpg");//此流用于将图片写入到本地	
		
		 byte[] buf = StreamUtils.streamToByteArray(inputStream);
			
		 fos.write(buf);




	
	
	
	

	

		

	



	


