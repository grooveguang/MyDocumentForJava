Centos7开启80端口
======

by `groovyguang`

#### [返回linux目录](./LinuxDirectory.md) [回到首页目录](/README.md)
  
最近在虚拟机上安装了centos7，安装nginx之后虚拟机内能访问，真机不能访问，修改iptables配置也不起作用，最后上网查找了资料后才发现centos的防火墙改成了firewall,不再叫iptables,开放端口的方法如下：


    firewall-cmd --zone=public --add-port=80/tcp --permanent  

命令含义：
 
     --zone #作用域
 
     --add-port=80/tcp  #添加端口，格式为：端口/通讯协议
 
     --permanent   #永久生效，没有此参数重启后失效

重启防火墙：

    systemctl stop firewalld.service  
    systemctl start firewalld.service  
