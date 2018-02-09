Linux 性能检查
======
by `groovyguang`
#### [返回linux目录](./LinuxDirectory.md) [回到首页目录](/README.md)

| 类别 | 监控命令 | 描述 | 备注 |
|:------:|:---------:|:------:|:-----:|
| 内存瓶颈 | free | 查看内存使用 |  |

|   | vmstat 3(间隔时间) 100(监控次数) | 查看swap in/out详细定位是否存在性能瓶颈 | 推荐使用 |

|  | sar -r 3 | 和free命令类似，查看内存的使用情况，但是不包含swap的情况 |  |

| cpu瓶颈 | top -H | 按照cpu消耗高低进行排序 |  |

|  | ps -Lp 进程号 cu | 查看某个进程的cpu消耗排序 |  |

|  | ```cat /proc/cpuinfo |grep ‘processor’|wc -l``` | 查看cpu核数 |  |


