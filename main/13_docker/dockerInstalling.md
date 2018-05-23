## 安装docker

### 1 通过daocloud安装

Docker 的 安装资源文件 存放在Amazon S3，会间歇性连接失败。所以安装Docker的时候，会比较慢。
你可以通过执行下面的命令，高速安装Docker

	curl -sSL https://get.daocloud.io/docker | sh

### 2 通过yum安装docker

yum安装docker，就是我们直接使用yum -y install docker安装docker，如下：

	yum -y install docker

### 3 通过yum安装docker-engine

yum安装docker-engine，就是我们直接使用yum -y install docker-engine安装docker。

简写（单独运行）

	yum -y install docker-ce

安装阿里云的docker-engine源，如下：

```
cat > /etc/yum.repos.d/docker.repo <<EOF
[dockerrepo]
name=Docker Repository
baseurl=https://mirrors.aliyun.com/docker-engine/yum/repo/main/centos/7/
enabled=1
gpgcheck=0
gpgkey=https://yum.dockerproject.org/gpg
EOF
```
如下：

	yum -y install docker-engine

## 启动docker，使用如下命令行：

	systemctl start docker
	systemctl enable docker
	systemctl status docker

## 查看docker

	docker version
	docker info

## 解决docker-runc not installed on system

	cd /usr/libexec/docker/
	sudo ln -s docker-runc-current docker-runc 

## 删除docker

RHEL|Centos

	sudo yum remove docker \
	docker-common \
	container-selinux \
	docker-selinux \
	docker-engine

Ubuntu|Debian

	sudo apt-get remove docker docker-engine

Fedora

	sudo dnf remove docker \
	docker-common \
	container-selinux \
	docker-selinux \
	docker-engine

卸载Docker后,/var/lib/docker/目录下会保留原Docker的镜像,网络,存储卷等文件. 如果需要全新安装Docker,需要删除/var/lib/docker/目录

	rm -fr /var/lib/docker/

## 修改默认docker仓库地址

docker安装完毕后，默认是从https://registry-1.docker.io仓库地址下载镜像的。

由于众所周知的原因，从docker hub下载镜像比较慢的。我们可以使用国内网易的docker仓库。

修改/usr/lib/systemd/system/docker.service文件，如下：

	vim /usr/lib/systemd/system/docker.service

	ExecStart=/usr/bin/dockerd --registry-mirror=http://hub.c.163.com -H tcp://0.0.0.0:2375 -H unix:///var/run/docker.sock

重启docker服务，如下：

	systemctl daemon-reload
	systemctl restart docker
	systemctl status docker

从仓库拉取镜像

	docker images
	docker pull nginx