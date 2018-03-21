MySql JDBC
====
##
### [返回MySql目录](./MySqlDirectory.md) [回到首页目录](/README.md)

##JDBC的概念

JDBC：Java Database Connectivity 是sun公司推出的一套java应用程序访问数据库的规范

规范：抽象类或接口

java.sql包下的一套接口或类
javax.sql包下的



##JDBC的好处

	1、不需要记住多套API，大大减轻了开发压力

	2、提高维护性



##JDBC常见的API
	
	DriverManager 类
		registerDriver :注册驱动 ，但不建议用，而是采用动态加载方式
		getConnection:获取连接，有三种方式
	
	Connection 接口 ★
		createStatement():创建并获取命令对象，用于执行sql语句
		prepareStatement(sql):创建并获取预编译命令对象，用于执行sql语句
	
	Statement 接口
		executeUpdate(String sql):执行增删改sql语句，返回受影响的行数
		executeQuery(String sql):执行查询sql语句，返回ResultSet结果集对象
		execute(String sql):执行任何sql语句，如果结果是结果集返回true，否则返回false
	PreparedStatement接口 ★
		executeUpdate():执行增删改sql语句，返回受影响的行数
		executeQuery():执行查询sql语句，返回ResultSet结果集对象
		execute():执行任何sql语句，如果结果是结果集返回true，否则返回false

		setXX(参数索引，参数值)：设置参数的值
		setObject(参数索引，参数值):设置产生的值
		参数索引：表示?的索引，从1开始！！！
		
		
	
	ResultSet 接口 ★
		next：先判断下一行是否有值，并让光标下移一位
		getXX(int columnIndex):根据列下标，获取该列的值，返回类型：XX
		getXX(String columnName):根据字段名获取该列的值，返回类型：XX
	
		getObject(int columnIndex):根据列下标，获取该列的值，返回类型：Object
		getObject(String columnName):根据字段名获取该列的值，返回类型：Object
	
		特点：每次只能下移一行

##通过案例演示JDBC的完整使用步骤 ☆（掌握步骤，代码可以不记住）
		//1.注册驱动
		DriverManager.registerDriver(new Driver());
		
		//2.建立连接
		/*
		 * 参数1：连接url
		 * jdbc:mysql://数据库服务器主机名:端口号/数据库名
		 * 
		 * 参数2：用户名
		 * 参数3：密码
		 * 
		 * 
		 */
		Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/stu","root","root");
		
		
		//3.操作数据
		//3-1 获取执行sql语句的命令对象
		Statement statement = connection.createStatement();
		
		//3-2执行sql语句
		int update = statement.executeUpdate("update student set studentname ='白云' where studentno='s199'");
		
		//3-3处理执行后的结果
		if (update>0) {
			System.out.println("修改成功！！！");
		}
		
		
		//4.关闭连接
		
		statement.close();
		connection.close();


			
##Blob类型数据的插入和获取



###相关API

	Blob类的getBinaryStream()方法，返回字节读取流对象

###插入
	Connection connection = DBUtils.getConnection();
		
		PreparedStatement statement = connection.prepareStatement("insert into star values(null,'mnls',?)");
		
		statement.setBlob(1, new FileInputStream("src/mnls.jpg"));
		
		int executeUpdate = statement.executeUpdate();
		
		if (executeUpdate>0) {
			System.out.println("success");
		} else {
			System.out.println("failure");

		}
		
		
		DBUtils.release(connection, statement, null);


###获取


		Connection connection = DBUtils.getConnection();
		
		PreparedStatement statement = connection.prepareStatement("select * from star where id=1");
		ResultSet set = statement.executeQuery();
		if (set.next()) {
			
			Blob blob = set.getBlob("photo");
			
			//获取二进制流对象  ★
			InputStream stream = blob.getBinaryStream();
			
			//一边读一边写
			
			byte[] arrs = StreamUtils.streamToByteArray(stream);
			
			FileOutputStream fos = new FileOutputStream("src/xiaohua.jpg");
			
			fos.write(arrs);
			
			fos.close();
			
		}
		DBUtils.release(connection, statement, set);

##批处理
###相关API

	Statement对象的
		addBatch方法：  添加到批处理
		executeBatch方法： 执行批处理语句
		clearBatch方法：清空批处理



	注意：

	1.需要用到新的连接jar包，原来的jar包移除

	2.url字符串需要改写成如下形式

	jdbc:mysql://localhost:3306/test?rewriteBatchedStatements=true


###相关代码


	@Test
	public void testBatch(){
		
		
		Connection connection=null;
		
		PreparedStatement statement =null;
		
		
		try {
			connection = DBUtils.getConnection();
			
			
			statement= connection.prepareStatement("insert into users values(null,?,'男','zhangwuji@qq.com',now())");

		
			for (int i =1; i <=50000; i++) {
				
				
				
				statement.setString(1, "张无忌"+i);
				
				statement.addBatch();//添加到批处理的语句中
				
				if (i%1000==0) {//每500条sql语句执行一次
					
					statement.executeBatch();//真正的执行
					
					statement.clearBatch();//清空缓存
					
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally{
			DBUtils.release(connection, statement, null);
		}
		
	}
	
##事务 应用程序提交和回滚事务

###相关API

	Connection对象的方法

		setAutoCommit(false);取消自动提交

		commit();提交事务
		rollback（）；回滚事务

###相关代码：

	@Test
	public void testBatch(){
		
		Connection connection = null;
		try {
			
			//1获取连接
			 connection=DBUtils.getConnection();
			 
			 //2.开启事务 (start transaction)
			 connection.setAutoCommit(false);//取消每一行的自动提交
			 //执行一条修改语句
			 update(connection,"update users set name='周芷若' where id=?",1);
			 
			 int i = 10/1;//模拟异常
			//执行第二条修改语句
			 update(connection,"update users set name='赵敏' where id=?",2);
			 
			 
			 //3.异常没有出现，提交事务(commit)
			 
			 connection.commit();
		} catch (SQLException e) {
			
			//4.异常出现后，回滚事务（rollback）
			try {
				connection.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		}
	
		
	}

##数据库连接池
###作用

	1、数据库连接对象的复用
	2、提高了连接的效率，不用每次都去连数据库服务器，只需要从数据库连接池中找可用连接对象即可
	3、不用每次关闭连接对象，而是把它放回到连接池



###方式一：使用C3P0
	// 1.创建连接池对象

		ComboPooledDataSource cpds = new ComboPooledDataSource();

		// 2.设置驱动类
		cpds.setDriverClass("com.mysql.jdbc.Driver"); // loads the jdbc driver
		// 3.设置连接url
		cpds.setJdbcUrl("jdbc:mysql://localhost:3306/stu");
		// 4.设置用户名
		cpds.setUser("root");
		// 5.设置密码
		cpds.setPassword("root");

		// 设置连接池中的其他配置信息

		// 设置连接池中初始的连接个数
		cpds.setInitialPoolSize(10);
		// 设置 连接池的最大连接个数
		cpds.setMaxPoolSize(20);
		// 设置 连接池的最小连接个数

		cpds.setMinPoolSize(5);

		// 设置增长量
		cpds.setAcquireIncrement(3);

		// 获取连接对象

		Connection connection = cpds.getConnection();

		System.out.println(connection);

		// 关闭连接：不是断开，放回连接池
		connection.close();

###方式二:使用dbcp
	@Test
	public void testDbcp1() throws  Exception {
		
		
		Properties properties = new Properties();
		
		properties.load(new FileInputStream("dbcp.properties"));
		DataSource dataSource = BasicDataSourceFactory.createDataSource(properties );
		
		Connection connection = dataSource.getConnection();
		
		System.out.println(connection);
		
		connection.close();

	}

Tips:

	后面学的hibernate 官方推荐使用 c3p0
	
	tomcat 使用的是dbcp


#封装DAO

以学生管理系统为 示例：

	实体类：domain
		
		Student
		Admin

	
	业务逻辑层：service
		特点：与界面无关，里面不允许有输入、输出

		方法1：管理员的登录验证
		方法2：按学号查询学生
		方法3：按姓名查询学生
		方法4：插入学生
		方法5：修改学生
		方法6：删除学生

	界面层：view
		特点：与界面相关


	Dao层：data  access object 数据访问对象层

		方式1：查询单个对象，针对于任何表
		方法2：查询多个对象，针对于任何表
		方法3：查询单个值，针对于任何表
		方法4：通用的增删改
		

		


		