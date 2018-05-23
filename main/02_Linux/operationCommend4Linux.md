	netstat -na | grep 7651 
查看本机7651端口在和谁通信 

	ps aux | grep 7651
查看本机7651进程的相关信息

	md5sum 文件名
用于查看文件的md5值，常用于检查文件是否一致

	ps aux --sort -rss
显示各个进程对内存的使用情况，从大到小排序

	netstat -ntpl
查看处于监听状态的TCP类型的端口

	netstat -nupl
查看处于监听状态的UDP类型的端口

	ps huH p 7651 | wc -l
查看进程7651所拥有的线程数

	tcpdump -i any -vv -Xs 0 port 8080 -w temp.cap
TCP抓包命令，用于抓取传到该主机8080端口的http请求，存于文件temp.cap
抓下来的包可以用strings命令读取

	netstat -nap | grep 7651
查看进程7651占用的端口

	netstat -na | grep “2181” | wc -l
查看连接到本机2181端口上的连接数

	lsof -i:2181
查看端口2181的运行情况