Redis Commend
====
##
### [返回Redis目录](./RedisDirectory.md)

## 通用命令

keys *

•  查询当前库的所有键


	exists <key>


•  判断某个键是否存在

    type <key>

•  查看键的类型

    del <key>

•  删除某个键

	expire <key> <seconds>

•  为键值设置过期时间，单位秒。

	ttl <key>

• 查看还有多少秒过期，-1 表示永不过期，-2 表示已过期

	dbsize

• 查看当前数据库的key 的数量

	flushdb

• 清空当前库

	flushall

• 通杀全部库


## String 

String 是 Redis 最基本的类型，你可以理解成与Memcached 一模一样的类型，一个 key 对应一个 value 。

String 类型是二进制安全的。意味着 Redis 的 string 可以包含任何数据。比如 jpg象 图片或者序列化的对象  。

String 类型是 Redis 最基本的数据类型，一个 Redis 中字符串 value 最多可以是

	get <key>

•  查询对应键值

	set <key> <value>

•  添加键值对

	append <key> <value>

•  将给定的<value>  追加到原值的末尾

	strlen <key>

•获得值的长度

	setnx <key> <value>

只有在 key  不存在时设置 key

	incr <key>

•  将 key  中储存的数字值增1
•  只能对数字值操作，如果为空，新增值为1

	decr <key>

•  将 key  中储存的数字值减1
•  只能对数字值操作，如果为空，新增值为-1

	incrby / decrby <key> < 步长>

•  将 key中储存的数字值增减。自定义步长。


原子性

• 所谓原子操作是指不会被线程调度机制打断的操作；这种操作一旦开始，就一
直运行到结束，中间不会有任何 context switch （切换到另一个线程）。

（1） 在单线程中， 能够在单条指令中完成的操作都可以认为是" 原子操作"，因为中断只能发生于指令之间。

（2）在多线程中，不能被其它进程（线程）打断的操作就叫原子操作。

Redis 单命令的原子性主要得益于 Redis 的单线程

java 中的 i++ 是否是原子操作？


	mset <key1> <value1> <key2> <value2> .....

•  同时设置一个或多个 key-value对 对

	mget <key1> <key2> <key3> .....

•  同时获取一个或多个 value

	msetnx <key1> <value1> <key2> <value2> .....

• 个 同时设置一个或多个 key-value  对，当且仅当所有给定key  都不存在。

	getrange <key> < 起始位置> < 结束位置>

•  获得值的范围，类似java 中的substring

	setrange <key> < 起始位置> <value>

•  用 <value>  覆写<key>  所储存的字符串值，从<起始位置> 开始。

	setex <key> < 过期时间> <value>

•  设置键值的同时，设置过期时间，单位秒。

	set k1 v1
	expire k1 10
	pexpire k1 10000
	set k1 v1 EX 10/ PX 10000
	pexpireat
	  expireat

next

	getset <key> <value>

•  以新换旧，设置了新值同时获得就值。

[返回顶部](#readme)
