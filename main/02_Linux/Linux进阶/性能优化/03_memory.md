
内存的特点:

速度快,所存数据不会保存,内存的最大消耗来源于进程

内存存储的数据有那些?

程序代码,程序定义的变量(初始化和未初始化),继承父进程的环境变量,进程读取的文件,程序需要的库文件.还有程序本身动态申请的内存存放自己的数据

除了进程以外还有内核也要占用,还有buffer和cache,还有共享内存(如共享库)

我们使用管道符| 进程之间通讯也要使用到内存,socket文件

那我们可以优化那部分程序?
	
	内核内存不能省
	buffer/cache不能省
	进程通讯不省


2的32次方 32位系统支持的内存  windows受到约束
 
linux只要换个pae(物理地址扩展)内核 可以支持2的36次方，2的64次方 

查看系统内存信息
	
	[root@localhost ~]# free -m
			total 	used 	free 	shared 	buffers 	cached
	Mem: 	1010 	981 		29 		0 		145 		649
	-/+ buffers/cache: 	186 		824
	Swap: 	2047 	0 		2047

buffer 索引缓存 存inode信息

cache 页缓存 存block信息

	# cat /proc/meminfo
	MemTotal:     16344972 kB
	MemFree:      13634064 kB
	Buffers:          3656 kB
	Cached:        1195708 kB
	SwapCached:          0 kB
	Active:         891636 kB
	Inactive:      1077224 kB
	HighTotal:    15597528 kB
	HighFree:     13629632 kB
	LowTotal:       747444 kB
	LowFree:          4432 kB
	SwapTotal:           0 kB
	SwapFree:            0 kB
	Dirty:             968 kB
	Writeback:           0 kB
	Mapped:         280372 kB
	Slab:           684068 kB
	CommitLimit:   7669796 kB
	Committed_AS:   100056 kB
	PageTables:      24448 kB
	VmallocTotal:   112216 kB
	VmallocUsed:       428 kB
	VmallocChunk:   111088 kB

MemTotal: 所有可用RAM大小 （即物理内存减去一些预留位和内核的二进制代码大小）

MemFree: LowFree与HighFree的总和

Buffers: 用来给块设备做的缓冲大小（只记录文件系统的metadata以及 tracking in-flight pages，就是说 buffers是用来存储，目录里面有什么内容，权限等等。）

Cached: 用来给文件做缓冲大小（直接用来记忆我们打开的文件）. 它不包括SwapCached

SwapCached: 已经被交换出来的内存，但仍然被存放在swapfile中。用来在需要的时候很快的被替换而不需要再次打开I/O端口。

Active: 最近经常被使用的内存，除非非常必要否则不会被移作他用.

Inactive: 最近不经常被使用的内存，非常用可能被用于其他途径.

HighTotal:

HighFree: 高位内存是指所有在860MB以上的内存空间，该区域主要用于用户空间的程序或者是缓存页面。内核必须使用不同的手法使用该段内存，因此它比低位内存要慢一些。

LowTotal:

LowFree: 低位可以达到高位内存一样的作用，而且它还能够被内核用来记录一些自己的数据结构.

Among many   other things, it is where everything from the Slab is  allocated.  Bad things happen when you're out of lowmem.

SwapTotal: 交换空间的总和

SwapFree: 从RAM中被替换出暂时存在磁盘上的空间大小

Dirty: 等待被写回到磁盘的内存大小。

Writeback: 正在被写回到磁盘的内存大小。

Mapped: 影射文件的大小。

Slab: 内核数据结构缓存

VmallocTotal: vmalloc内存大小

VmallocUsed: 已经被使用的虚拟内存大小。

VmallocChunk: largest contigious block of vmalloc area which is free

	mpstat
	vmstat
	iostat
	netstat


find测试1

	[root@localhost ~]# vmstat
	procs -----------memory----------    ---swap--   -----io---- 	--system-- -----cpu------
	r b 	swpd free   buff       cache     	si 	so 	bi 	bo 	in 	cs 	  us sy id wa st
	0 0 	0 	48584 118300 663564   	0  	0  	12 	23 	60 	240 	   3  2   95 0  0

procs

	r 列表示运行和等待cpu时间片的进程数，如果长期大于cpu个数，说明cpu不足，需要增加cpu。
	b 列表示在等待资源的进程数，比如正在等待I/O、或者内存交换等。

memory

	swpd 切换到内存交换区的内存数量(k表示)。如果swpd的值不为0，或者比较大，比如超过了100m，只要si、so的值长期为0，系统性能还是正常
	free 当前的空闲页面列表中内存数量(k表示)
	buff 作为buffer cache的内存数量，一般对块设备的读写才需要缓冲。
	cache: 作为page cache的内存数量，一般作为文件系统的cache，如果cache较大，说明用到cache的文件较多，如果此时IO中bi比较小，说明文件系统效率比较好。

swap

	si 由内存进入内存交换区数量。
	so由内存交换区进入内存数量。

IO

	bi 从块设备读入数据的总量（读磁盘）（每秒kb）。
	bo 块设备写入数据的总量（写磁盘）（每秒kb）
    system 显示采集间隔内发生的中断数
	in 列表示在某一时间间隔中观测到的每秒设备中断数。
	cs列表示每秒产生的上下文切换次数，如当 cs 比磁盘 I/O 和网络信息包速率高得多，都应进行进一步调查。

buffer/cache

根据时间和数据大小同步

	[root@localhost ~]# cat /proc/sys/vm/dirty_
	dirty_background_ratio 	dirty_ratio
	dirty_expire_centisecs 	dirty_writeback_centisecs
	
	[root@localhost ~]# cat /proc/sys/vm/dirty_writeback_centisecs
	499
5秒同步一次脏数据

	[root@localhost ~]# cat /proc/sys/vm/dirty_ratio 40
如果单个进程占用的buffer/cache达到内存总量的40%,立刻同步。

	[root@localhost ~]# cat /proc/sys/vm/dirty_background_ratio 10
所有进程占用的buffer/cache使得剩余内存低于内存总量的10%，立刻同步

	[root@localhost ~]# cat /proc/sys/vm/dirty_expire_centisecs 2999
30秒之内数据必须被同步*

释放buffer/cache

	[root@localhost ~]# cat /proc/sys/vm/drop_caches 0
	1 释放buffer
	2 释放cache
	3 buffer/cache都释放

提升内存的访问性能

实现使用多种不同的页面大小 一部分使用4k 一部分使用大页面

hugetlbfs 启动该文件系统

	cat /proc/meminfo |　grep -i Huge

可以查询大页面大小2M 未启动状态

启用可以有两种方法

1.vim /etc/sysctl.conf

	vm.nr_hugepages=n
	sysctl -w vm.nr_hugepages=10

2.内核参数

	hugepages=n

创建好后可以指定给大页面使用.也可以直接使用大页面文件系统(关机后消
失)

	mkdir /hugepages
	mount -t hugetlbfs none /hugepages

有些应用程序会自动使用大页面,只有应用程序明确使用大页面才挂载

mysql参数innodb_buffer 需要很大的内存空间并且反复申请,如使用大页面,能有效提高其性能,而这时不需要挂载

将文件元数据缓存到内存中buffer cache

vm.min_free_kbytes 内存的剩余空间,如果内存分配完了 系统会崩溃
内存不够用时可以调整小一点 增大内存使用的空间

调整内存的过量使用(使用虚拟化环境)

	vm.overcommit_memory

过量使用:

	只有4核心cpu，给虚拟机 2 2 2 2 8个cpu  这就是cpu的过量使用
	只有8G内存 分出每个虚拟机4G 3个虚拟机 超出物理内存的过量使用(能超
	出一部分) 以swap为前提 但是swap性能差

如何使用swap

	vm.overcommit_memory
	0 = hueristic overcommit (启发式过量,有内核自己决定是否过量 默认)
	1 = always overcommit (总是过量使用,不要在数据库服务器使用,可以在
	hadoop服务使用,本身是一个批处理系统,需要大量内存运算时)
	2 = commit all ram plus a percentage of swap(mybe > 100)百分比

vm.overcommit_ratio可以超出物理内存百分比(只有上个参数为2时才有意
义 如50) 

物理内存2G  ram就是3G  但是交换如果是512Ｍ 那系统可能就会崩溃,所以
不要超出你的交换空间 否则就会出现OOM(out of memory)内存溢出

内存溢出的后果

如果内存溢出了 内核又要执行操作怎么办?他就会找使用内存大的进程不管
它是谁直接杀死,以提供内存空间.所以内核中有oom killer
 
当然我们也可以控制oom killer杀死那个进程 通常根据谁像坏蛋这种方式,
每个进程都会有个评分

ls /proc/1目录下会有oom_score存分数 谁的分数高先干死谁

oom_score_adj调整因子,它会使进程调整高优先杀死或者调低最后杀死

vm.lowmem_reserve_ratio 低端内存使用多少空间
 
	vfs_cache_pressure

控制内核回收缓存目录和缓存inode对象的内存,一般不回收
 
默认值100,表示倾向性page cache和swap相同 只有能回收pagecache 就有
可能回收这部分内存

设置0 绝对不回收,但是有可能内存溢出(最好不要等于0)

1-99之间表示倾向于不回收

大于100更倾向于回收 


page-cluster 页簇

	如果需要将数据从内存交换到交换空间时 一次交换出多少个页面
	如果值为1 表示1次交换出2的1次方个 
	如果值为2 表示1次交换出2的2次方个
	如果只为3 表示1次交换出2的3次方个

频繁使用交换分区时,调大该值,不超过4.获得稍微的性能改进,在虚拟化场
景中,云计算场景中,可能会用到.这也是虚拟机环境优化的一个比较常用的
方式 .

调整网络io的arp缓存

	/proc/net/arp(默认512软限制 1024硬限制。超出512的部分会使用很短时
	间。超出部分会被系统中的垃圾收集器移除）arp缓存5分钟
	处于一个非常大的物理网络中的时候可以调大(一个网络中主机非常多的时
	候)

	ip neighbor list  列出所有条目

	ip neighbor flush dev ethX  清空所有条目

参数(默认arp缓存时间5分钟)

	net.ipv4.neigh.default.gc_thresh1 (清理阈值)
	default 128  清理阈值 小于128不会清理(包括过期了也不清理，超出128
	清理过期条目)

net.ipv4.neigh.default.gc_thresh2　软限制

	default 512 清理过期的和超出软限制(超出软限制最多允许存在5秒钟)

net.ipv4.neigh.default.gc_thresh3　硬限制(1024)

net.ipv4.neigh.default.gc_interval 清理周期


查看内存使用情况

	[root@localhost ~]# sar -r 1 1


内存测试

	[root@localhost ~]# yum install memtest86+
	[root@localhost ~]# memtest-setup
	Setup complete.

重新启动系统是使用memtest86+
