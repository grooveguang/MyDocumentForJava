MySql Framing Introduce
====
##
### [返回Nginx目录](./NginxDirectory.md) [回到首页目录](/README.md)

## Introduce MySql

MySQL是一个关系型数据库管理系统，由瑞典MySQL AB公司开发，目前属于Oracle公司。

MySQL是一种关联数据库管理系统，将数据保存在不同的表中，而不是将所有数据放在一个大仓库内，这样就增加了速度并提高了灵活性。
 
Mysql是开源的，所以你不需要支付额外的费用。

Mysql是可以定制的，采用了GPL协议，你可以修改源码来开发自己的Mysql系统。

Mysql支持大型的数据库。可以处理拥有上千万条记录的大型数据库。

MySQL使用标准的SQL数据语言形式。

Mysql可以允许于多个系统上，并且支持多种语言。这些编程语言包括C、C++、Python、Java、Perl、PHP、Eiffel、Ruby和Tcl等。

MySQL支持大型数据库，支持5000万条记录的数据仓库，32位系统表文件最大可支持4GB，64位系统支持最大的表文件为8TB。

## Installing mysql5.5 

[官网下载地址](http://dev.mysql.com/downloads/mysql/)

### 检查工作：

   检查当前系统是否安装过mysql执行安装命令前，先执行查询命令

     rpm -qa|grep mysql

![](./img/mysqlLib.png)

如果存在mysql-libs的旧版本包如下：

请先执行卸载命令：
    rpm -e --nodeps  mysql-libs

检查/tmp文件夹权限

	由于mysql安装过程中，会通过mysql用户在/tmp目录下新建tmp_db文件，所以请给/tmp较大的权限执行 ：
    chmod -R 777 /tmp

### 安装：

在mysql的安装文件目录下执行：

	rpm -ivh MySQL-client-5.5.54-1.linux2.6.x86_64.rpm
	rpm -ivh MySQL-server-5.5.54-1.linux2.6.x86_64.rpm

查看Mysql安装版本

或者可以执行`mysqladmin --version`命令，类似`java -version`如果打出消息，即为成功。

![](./img/version.png)

通过vim 查看 mysql用户和mysql组

### mysql服务的启+停

启动：

![](./img/start.png)

关闭：

![](./img/stop.png)

### 首次登录

 安装完成后会提示出如下的提示：

在mysql首次登录前要给 `root` 账号设置密码

![](./img/installing.png)

启动服务后，执行命令

	/usr/bin/mysqladmin -u root  password '123123'

![](./img/setUser.png)

然后通过 `mysql -uroot -p123123`进行登录

![](./img/enter.png)
	
	
## mysql的安装位置，在Linux下查看安装目录 

|参数|路径|解释|备注|
| :--: | :--: | :--: | :--: |
| --basedir | /usr/bin | 相关命令目录 | mysqladmin mysqldump等命令 |
| --datadir | /var/lib/mysql/ |mysql数据库文件的存放路径 |  | -plugin-dir | /usr/lib64/mysql/plugin | mysql插件存放路径 |  |
| --log-error | /var/lib/mysql/jack.atguigu.err | mysql错误日志路径 |  |
| --pid-file | /var/lib/mysql/jack.atguigu.pid | 进程pid文件 |  |
| --socket | /var/lib/mysql/mysql.sock | 本地连接时用的unix套接字文件 |  |
|  | /usr/share/mysql | 配置文件目录 | mysql脚本及配置文件 |
|  | /etc/init.d/mysql | 服务启停相关脚本 |  |

 
### 在linux下查看安装目录 
 	
	ps -ef|grep mysql

### 自启动mysql服务

![](./img/psMySql.png)

![](./img/startServer.png)

 


### 修改字符集问题

尝试插入输入：

![](./img/insertWithCh.png)

原因是字符集问题

1 查看字符集

	show variables like 'character%';
	show variables like '%char%';

看看出现的结果：

![](./img/charter.png)

默认的是客户端和服务器都用了latin1，所以会乱码。

2 修改my.cnf

在`/usr/share/mysql/` 中找到`my.cnf`的配置文件，
拷贝其中的`my-huge.cnf` 到 `/etc/`  并命名为`my.cnf`
然后修改`my.cnf`:

	[client]
	default-character-set=utf8
	[mysqld]
	character_set_server=utf8
	character_set_client=utf8
	collation-server=utf8_general_ci
	[mysql]
	default-character-set=utf8

![](./img/charterSet.png)

![](./img/defaultCharter.png)

 3、重新启动mysql
  
  但是原库的设定不会发生变化，参数修改之对新建的数据库生效
 
4、已生成的库表字符集如何变更

修改数据库的字符集

	mysql> alter database mytest character set 'utf8';

修改数据表的字符集

	mysql> alter table user convert to  character set 'utf8';
 
但是原有的数据如果是用非'utf8'编码的话，数据本身不会发生改变。

[返回顶部](#readme)


## 二进制日志log-bin

主从复制及备份恢复

    my.cnf中的log-bin配置

错误日志log-error   

     默认是关闭的,记录严重的警告和错误信息，每次启动和关闭的详细信息等。

慢查询日志log（0-10秒）

         默认关闭，记录查询的sql语句，如果开启会减低mysql的整体性能，因为记录日志也是需要消耗系统资源的

数据文件：

     1、两系统
           Windows  ....\MySQLServer5.5\data  目录下很多数据库文件
           Linux    默认路径：/var/lib/mysql  每个目录代表一个同名的库
     2、Myisam存放方式
           frm文件   存放表结构
           myd文件   存放表数据
           myi文件   存放表索引
     3、innodb存放方式
           ibdata1
           frm文件   存放表结构
           单独存放
```
create table mmm (id int(20) auto_increment ,name varchar(20),primary key(id)); 
```

如何配置：

     Windows   my.ini文件
     linux     /etc/my.cnf文件


MySQL的用户管理

   1、创建用户

	create user zhang3 identified by '123123';
表示创建名称为zhang3的用户，密码设为123123；

   2、了解user表

查看用户

	select host,user,password,select_priv,insert_priv,drop_priv from mysql.user;

 host ：   表示连接类型

        % 表示所有远程通过 TCP方式的连接
        IP 地址 如 (192.168.1.2,127.0.0.1) 通过制定ip地址进行的TCP方式的连接
       机器名   通过制定i网络中的机器名进行的TCP方式的连接
        ::1   IPv6的本地ip地址  等同于IPv4的 127.0.0.1
        localhost 本地方式通过命令行方式的连接 ，比如mysql -u xxx -p 123xxx 方式的连接。

  User:表示用户名

       同一用户通过不同方式链接的权限是不一样的。

 password ： 密码

       所有密码串通过 password(明文字符串) 生成的密文字符串。加密算法为MYSQLSHA1 ，不可逆 。
        mysql 5.7 的密码保存到 authentication_string 字段中不再使用password 字段。

  select_priv , insert_priv等

        为该用户所拥有的权限。

   3、设置密码

修改当前用户的密码:

	set password =password('123456')

修改某个用户的密码:

	update mysql.user set password=password('123456') where user='li4';

	flush privileges;  #所有通过user表的修改，必须用该命令才能生效。

   4、修改用户

修改用户名：

	update mysql.user set user='li4' where user='wang5';
	flush privileges;   #所有通过user表的修改，必须用该命令才能生效。

   5、删除用户

	drop user li4 ;

 不要通过`delete from  user u where user='li4' `进行删除，系统会有残留信息保留。


## 权限管理

   1、授予权限

授权命令：

	grant 权限1,权限2,…权限n on 数据库名称.表名称 to 用户名@用户地址 identified by ‘连接口令’;

该权限如果发现没有该用户，则会直接新建一个用户。

比如

```
grant select,insert,delete,drop on atguigudb.* to li4@localhost  ;
#给li4用户用本地命令行方式下，授予atguigudb这个库下的所有表的插删改查的权限。
 04_MySQL的用户与权限管理
#授予通过网络方式登录的的joe用户 ，对所有库所有表的全部权限，密码设为123.
```
   2、收回权限  

查看当前用户权限

	show grants;
收回权限命令：

	revoke  权限1,权限2,…权限n on 数据库名称.表名称  from  用户名@用户地址 ;

	REVOKE ALL PRIVILEGES ON mysql.* FROM joe@localhost;
`#收回全库全表的所有权限
 
    REVOKE select,insert,update,delete ON mysql.* FROM joe@localhost;
`#收回mysql库下的所有表的插删改查权限
 
 必须用户重新登录后才能生效 
 
  3、查看权限

查看当前用户权限

	show grants;

 查看某用户的全局权限
	
	select  * from user ;

 查看某用户的某库的权限

	select * from  db;

 查看某用户的某个表的权限

	select * from tables_priv;

通过工具远程访问

 1、先 ping 一下数据库服务器的ip 地址确认网络畅通。

 2、关闭数据库服务的防火墙

    service iptables stop

 3、 确认Mysql中已经有可以通过远程登录的账户

    select  * from mysql.user where user='li4' and host='%';
    如果没有用户,先执行如下命令：
    grant all privileges on *.*  to li4@'%'  identified by '123123';

 4、测试连接：







大小写问题
      
	SHOW VARIABLES LIKE '%lower_case_table_names%'

windows系统默认大小写不敏感，但是linux系统是大小写敏感的
默认为0，大小写敏感。

设置1，大小写不敏感。创建的表，数据库都是以小写形式存放在磁盘上，对于sql语句都是转换为小写对表和DB进行查找。

设置2，创建的表和DB依据语句上格式存放，凡是查找都是转换为小写进行。
 当想设置为大小写不敏感时，要在my.cnf这个配置文件 [mysqld] 中加入 lower_case_table_names = 1 ，然后重启服务器。

但是要在重启数据库实例之前就需要将原来的数据库和表转换为小写，否则将找不到数据库名。

在进行数据库参数设置之前，需要掌握这个参数带来的影响，切不可盲目设置。

## sql_mode

MySQL的sql_mode合理设置

sql_mode是个很容易被忽视的变量，默认值是空值，在这种设置下是可以允许一些非法操作的，比如允许一些非法数据的插入。在生产环境必须将这个值设置为严格模式，所以开发、测试环境的数据库也必须要设置，这样在开发测试阶段就可以发现问题。
 
sql_mode常用值如下：

	ONLY_FULL_GROUP_BY：

对于GROUP BY聚合操作，如果在SELECT中的列，没有在GROUP BY中出现，那么这个SQL是不合法的，因为列不在GROUP BY从句中
	
	NO_AUTO_VALUE_ON_ZERO：

该值影响自增长列的插入。默认设置下，插入0或NULL代表生成下一个自增长值。如果用户 希望插入的值为0，而该列又是自增长的，那么这个选项就有用了。

	 STRICT_TRANS_TABLES：

在该模式下，如果一个值不能插入到一个事务表中，则中断当前的操作，对非事务表不做限制

	NO_ZERO_IN_DATE：

在严格模式下，不允许日期和月份为零
	
	 NO_ZERO_DATE：

设置该值，mysql数据库不允许插入零日期，插入零日期会抛出错误而不是警告。

	 ERROR_FOR_DIVISION_BY_ZERO：

在INSERT或UPDATE过程中，如果数据被零除，则产生错误而非警告。如 果未给出该模式，那么数据被零除时MySQL返回NULL

	 NO_AUTO_CREATE_USER：

禁止GRANT创建密码为空的用户
	
	 NO_ENGINE_SUBSTITUTION：

如果需要的存储引擎被禁用或未编译，那么抛出错误。不设置此值时，用默认的存储引擎替代，并抛出一个异常

	 PIPES_AS_CONCAT：

将"||"视为字符串的连接操作符而非或运算符，这和Oracle数据库是一样的，也和字符串的拼接函数Concat相类似

	 ANSI_QUOTES：

启用ANSI_QUOTES后，不能用双引号来引用字符串，因为它被解释为识别符
 
ORACLE：

    设置等同：PIPES_AS_CONCAT, ANSI_QUOTES, IGNORE_SPACE, NO_KEY_OPTIONS, NO_TABLE_OPTIONS, NO_FIELD_OPTIONS, NO_AUTO_CREATE_USER.
 

## 总体概览

和其它数据库相比，MySQL有点与众不同，它的架构可以在多种不同场景中应用并发挥良好作用。主要体现在存储引擎的架构上，

插件式的存储引擎架构将查询处理和其它的系统任务以及数据的存储提取相分离。这种架构可以根据业务的需求和实际需要选择合适的存储引擎。

1.连接层

最上层是一些客户端和连接服务，包含本地sock通信和大多数基于客户端/服务端工具实现的类似于tcp/ip的通信。

主要完成一些类似于连接处理、授权认证、及相关的安全方案。在该层上引入了线程池的概念，为通过认证安全接入的客户端提供线程。

同样在该层上可以实现基于SSL的安全链接。服务器也会为安全接入的每个客户端验证它所具有的操作权限。

2.服务层
   2.1  Management Serveices & Utilities： 系统管理和控制工具 
   2.2  SQL Interface: SQL接口
    
     接受用户的SQL命令，并且返回用户需要查询的结果。比如select from就是调用SQL Interface
    
   2.3 Parser: 解析器
    
     SQL命令传递到解析器的时候会被解析器验证和解析。
    
   2.4 Optimizer: 查询优化器。
    
     SQL语句在查询之前会使用查询优化器对查询进行优化。
    
     用一个例子就可以理解： select uid,name from user where  gender= 1;
    
    优化器来决定先投影还是先过滤。

   2.5 Cache和Buffer： 查询缓存。

      如果查询缓存有命中的查询结果，查询语句就可以直接去查询缓存中取数据。

      这个缓存机制是由一系列小缓存组成的。比如表缓存，记录缓存，key缓存，权限缓存等

 3.引擎层

  存储引擎层，存储引擎真正的负责了MySQL中数据的存储和提取，服务器通过API与存储引擎进行通信。

不同的存储引擎具有的功能不同，这样我们可以根据自己的实际需要进行选取。
 
后面介绍MyISAM和InnoDB

 4.存储层

  数据存储层，主要是将数据存储在运行于裸设备的文件系统之上，并完成与存储引擎的交互。

查询说明

查询流程图：

 首先，mysql的查询流程大致是：

mysql客户端通过协议与mysql服务器建连接，发送查询语句，先检查查询缓存，如果命中，直接返回结果，否则进行语句解析,也就是说，

在解析查询之前，服务器会先访问查询缓存(query cache)——它存储SELECT语句以及相应的查询结果集。

如果某个查询结果已经位于缓存中，服务器就不会再对查询进行解析、优化、以及执行。它仅仅将缓存中的结果返回给用户即可，这将大大提高系统的性能。

语法解析器和预处理：首先mysql通过关键字将SQL语句进行解析，并生成一颗对应的“解析树”。

mysql解析器将使用mysql语法规则验证和解析查询；预处理器则根据一些mysql规则进一步检查解析数是否合法。

查询优化器当解析树被认为是合法的了，并且由优化器将其转化成执行计划。

一条查询可以有很多种执行方式，最后都返回相同的结果。优化器的作用就是找到这其中最好的执行计划。

然后，mysql默认使用的BTREE索引，并且一个大致方向是:无论怎么折腾sql，至少在目前来说，mysql最多只用到表中的一个索引。

SQL执行顺序

1、手写

2、机读

随着Mysql版本的更新换代，其优化器也在不断的升级，优化器会分析不同执行顺序

产生的性能消耗不同而动态调整执行顺序。

   下面是经常出现的查询顺序：
  





查看命令

 1 如何用命令查看

	  #看你的mysql现在已提供什么存储引擎:
	  mysql> show engines;  

	  #看你的mysql当前默认的存储引擎:
	  mysql> show variables like '%storage_engine%';
 

## 各个引擎简介

1、InnoDB存储引擎

InnoDB是MySQL的默认事务型引擎，它被设计用来处理大量的短期(short-lived)事务。

除非有非常特别的原因需要使用其他的存储引擎，否则应该优先考虑InnoDB引擎。
 
2、MyISAM存储引擎

MyISAM提供了大量的特性，包括全文索引、压缩、空间函数(GIS)等，但MyISAM不支持事务和行级锁，

有一个毫无疑问的缺陷就是崩溃后无法安全恢复。

 3、Archive引擎

Archive存储引擎只支持INSERT和SELECT操作，在MySQL5.1之前不支持索引。

Archive表适合日志和数据采集类应用。

根据英文的测试结论来看，Archive表比MyISAM表要小大约75%，比支持事务处理的InnoDB表小大约83%。

 4、Blackhole引擎

Blackhole引擎没有实现任何存储机制，它会丢弃所有插入的数据，不做任何保存。

但服务器会记录Blackhole表的日志，所以可以用于复制数据到备库，或者简单地记录到日志。

但这种应用方式会碰到很多问题，因此并不推荐。

 5、CSV引擎

CSV引擎可以将普通的CSV文件作为MySQL的表来处理，但不支持索引。

CSV引擎可以作为一种数据交换的机制，非常有用。

CSV存储的数据直接可以在操作系统里，用文本编辑器，或者excel读取。

 6、Memory引擎

如果需要快速地访问数据，并且这些数据不会被修改，重启以后丢失也没有关系，

那么使用Memory表是非常有用。Memory表至少比MyISAM表要快一个数量级。

 7、Federated引擎

Federated引擎是访问其他MySQL服务器的一个代理，尽管该引擎看起来提供了一种很好的跨服务器的灵活性，但也经常带来问题，因此默认是禁用的。

[返回顶部](#readme)	
