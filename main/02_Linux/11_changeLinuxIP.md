Change Linux IP
======

by `groovyguang`

#### [返回linux目录](./LinuxDirectory.md) [回到首页目录](/README.md)

1：临时修改：
1.1：修改IP地址
# ifconfig eth0 192.168.100.100

1.2：修改网关地址
# route add default gw 192.168.100.1 dev eth0

1.3：修改DNS
# echo "nameserver 8.8.8.8" >> /etc/resolv.conf

这个时候就可以上网了，上网的IP地址为192.168.100.100，网关地址为192.168.100.1。但是这样的设置是临时性的，一旦重启网卡或者重启服务器，除了1.3的操作其他均会被还原，这样的方式只适合临时IP修改，想要永久性修改网卡配置文件，就需要修改相应的文件

2：永久性修改：
2.1：修改IP地址
修改/etc/sysconfig/network-scripts/ifcfg-eth0文件，如果有多张网卡，则修改相应的网卡
# vi /etc/sysconfig/network-scripts/ifcfg-eth0
DEVICE=eth0                              #网卡对应的设备别名
BOOTPROTO=static                    #网卡获得ip地址的方式（默认为dhcp，表示自动获取）
HWADDR=00:07:E9:05:E8:B4    #网卡MAC地址（物理地址）
IPADDR=192.168.100.100          #IP地址
NETMASK=255.255.255.0          #子网掩码 
ONBOOT=yes                              #系统启动时是否激活此设备


2.2：修改网关地址
修改/etc/sysconfig/network文件
# vi /etc/sysconfig/network
NETWORKING=yes                #表示系统是否使用网络，no表示不能使用网络
HOSTNAME=doiido                #设置本机的主机名，要和/etc/hosts中设置的主机名相同
GATEWAY=192.168.100.1      #设置网关的IP地址

这个时候已经可以ping通IP地址，但是还无法ping通域名，因此需要修改DNS

2.3：修改DNS
修改/etc/resolv.conf文件
# vi /etc/resolv.conf
nameserver 8.8.8.8                      #google域名服务器
nameserver 114.144.114.114      #国内域名服务器

2.4：重启网卡
# service network restart
正在关闭接口 eth0： [确定]
关闭环回接口： [确定]
弹出环回接口： [确定]
弹出界面 eth0： [确定]

这个时候，系统就可以正常的上网了

# 注：其实网关地址和DNS也是可以写在ifcfg-eth0中，但是为了规范起见，将他们分开写