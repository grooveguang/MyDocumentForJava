Nginx Commend
====
##
### [返回Nginx目录](./NginxDirectory.md) [回到首页目录](/README.md)

## [官方文档](http://nginx.org/en/docs/)

### 1.默认启动方式
  
    /usr/local/nginx/sbin/nginx
    安装时可以配置路径
    configure命令后加 --conf-path=PATH

### 2.另行指定配置文件的启动方式
    
    /usr/local/nginx/sbin/nginx -c /tmp/nginx.conf

### 3.另行指定安装目录的启动方式

    /usr/local/nginx/sbin/nginx -p /usr/local/nginx.conf

### 4.另行指定全局配置项的启动方式

    启动
    /usr/local/nginx/sbin/nginx -g "pid /var/nginx/test.pid;"
    关闭
    /usr/local/nginx/sbin/nginx -g "pid /var/nginx/test.pid;" -s stop

### 5.测试配置信息是否有错误

    /usr/local/nginx/sbin/nginx -t

### 6.在测试配置阶段不输出信息

    /usr/local/nginx/sbin/nginx -t -q

### 7.显示版本信息
  
    /usr/local/nginx/sbin/nginx -v

### 8.显示编译阶段的参数

    /usr/local/nginx/sbin/nginx -v

### 9.快速地停止服务

    /usr/local/nginx/sbin/nginx -s stop
    kill -s sigterm 10200
    kill -s sigint 10200

### 10.优雅地停止服务

    /usr/local/nginx/sbin/nginx -s quit
    kill -s sigquit xxxxx
    kill -s sigwinch xxxxx

### 11.使运行中的Nginx重读配置项并生效

    /usr/local/nginx/sbin/nginx -s reload

### 12.日志文件回滚

    /usr/local/nginx/sbin/nginx -s reopen


