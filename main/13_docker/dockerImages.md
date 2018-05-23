
### 1.搜索镜像

docker search <image> # 在docker index中搜索image

### 2.下载镜像

docker pull <image>  # 从docker registry server 中下拉image

### 3.查看镜像 

    docker images： # 列出images
    docker images -a # 列出所有的images（包含历史）
    docker rmi  <image ID>： # 删除一个或多个image

### 4.使用镜像创建容器

	docker run -i -t sauloal/ubuntu14.04
	docker run -i -t sauloal/ubuntu14.04 /bin/bash # 创建一个容器，让其中运行 bash 应用，退出后容器关闭
	docker run -itd --name centos_aways --restart=always centos #创建一个名称centos_aways的容器，自动重启
	# --restart参数：always始终重启；on-failure退出状态非0时重启；默认为，no不重启

### 5.查看容器

    docker ps ：列出当前所有正在运行的container
    docker ps -l ：列出最近一次启动的container
    docker ps -a ：列出所有的container（包含历史，即运行过的container）
    docker ps -q ：列出最近一次运行的container ID

### 6.再次启动容器

    docker start/stop/restart <container> #：开启/停止/重启container
    docker start [container_id] #：再次运行某个container （包括历史container）

### 7.进入正在运行的docker容器

    docker exec -it [container_id] /bin/bash
    docker run -i -t -p <host_port:contain_port> #：映射 HOST 端口到容器，方便外部访问容器内服务，host_port 可以省略，省略表示把 container_port 映射到一个动态端口。

### 8.删除容器

    docker rm <container...> #：删除一个或多个container
    docker rm `docker ps -a -q` #：删除所有的container
    docker ps -a -q | xargs docker rm #：同上, 删除所有的container

### docker run和docker create的区别 

docker run 和 docker create 参数基本一样，run是创建容器并后台启动，create是只创建容器。 

docker run 相当于docker create 和 docker star

	run创建容器：docker run -itd
	create创建： docker create -it
	    -t, --tty                       Allocate a pseudo-TTY
	    -i, --interactive               Keep STDIN open even if not attached
	    -d, --detach                    Run container in background and print container ID #run的参数

## docker容器系统启动参数

### 容器资源限制参数

	-m 1024m --memory-swap=1024m  # 限制内存最大使用（bug：超过后进程被杀死）
	--cpuset-cpus="0,1"           # 限制容器使用CPU

### docker容器随系统自启参数

	docker run --restart=always redis
	no – 默认值，如果容器挂掉不自动重启
	on-failure – 当容器以非 0 码退出时重启容器 
	同时可接受一个可选的最大重启次数参数 (e.g. on-failure:5).
	always – 不管退出码是多少都要重启

例如：

	docker run -itd --name test01 -p IP:sport:dport  -m 1024m --memory-swap=1024m --cpuset-cpus="0,1" --restart=always <image ID> 
	docker exec -it test01 bash  # 进入容器也可以用exec命令

### 查看容器状态信息

	docker stats
	docker stats --no-stream

## 进入容器-nsenter 命令

### nsenter安装 
nsenter 工具在 util-linux 包2.23版本后包含。 如果系统中 util-linux 包没有该命令，可以按照下面的方法从源码安装。

	cd /usr/src ; wget https://www.kernel.org/pub/linux/utils/util-linux/v2.28/util-linux-2.28.tar.gz
	./configure --without-ncurses
	make nsenter && sudo cp nsenter /usr/local/bin

### nsenter使用
 
nsenter 可以访问另一个进程的名字空间。nsenter 要正常工作需要有 root 权限。
 
为了连接到容器，你还需要找到容器的第一个进程的 PID，可以通过下面的命令获取。

	PID=$(docker inspect --format "{{ .State.Pid }}" <container>)

通过这个 PID，就可以连接到这个容器：

	nsenter --target $PID --mount --uts --ipc --net --pid

更简单的，建议下载 .bashrc_docker，并将内容放到 .bashrc 中。

	wget -P ~ https://github.com/yeasy/docker_practice/raw/master/_local/.bashrc_docker;
	echo "[ -f ~/.bashrc_docker ] && . ~/.bashrc_docker" >> ~/.bashrc; source ~/.bashrc

这个文件中定义了很多方便使用 Docker 的命令，例如 docker-pid 可以获取某个容器的 PID；而 
docker-enter 可以进入容器或直接在容器内执行命令。

	echo $(docker-pid <container>)
	docker-enter <container> ls
	docker-enter <container> bash

## 持久化容器与镜像

### 1 通过容器生成新的镜像

运行中的镜像称为容器。你可以修改容器（比如删除一个文件），但这些修改不会影响到镜像。不过，你使用docker commit 命令可以把一个正在运行的容器变成一个新的镜像。

	docker commit <container> [repo:tag] # 将一个container固化为一个新的image，后面的repo:tag可选。

### 2 持久化容器

export命令用于持久化容器

	docker export <CONTAINER ID> > /tmp/export.tar

### 3 持久化镜像

Save命令用于持久化镜像

	docker save 镜像ID > /tmp/save.tar

### 4 导入持久化container

删除container 2161509ff65e

	docker rm 2161509ff65e

导入export.tar文件

	cat /tmp/export.tar | docker import - export:latest

### 5 导入持久化image

删除image daa11948e23d

	docker rmi daa11948e23d

导入save.tar文件

	docker load < /tmp/save.tar

对image打tag

	docker tag daa11948e23d load:tag

### 6 export-import与save-load的区别

导出后再导入(export-import)的镜像会丢失所有的历史，而保存后再加载（save-load）的镜像没有丢失历史和层(layer)。这意味着使用导出后再导入的方式，你将无法回滚到之前的层(layer)，同时，使用保存后再加载的方式持久化整个镜像，就可以做到层回滚。（可以执行docker tag 来回滚之前的层）。

### 7 commend

 	docker logs $CONTAINER_ID #查看docker实例运行日志，确保正常运行
    docker inspect $CONTAINER_ID #docker inspect <image|container> 查看image或container的底层信息
    docker build <path> 寻找path路径下名为的Dockerfile的配置文件，使用此配置生成新的image
    docker build -t repo[:tag] 同上，可以指定repo和可选的tag
    docker build - < <dockerfile> 使用指定的dockerfile配置文件，docker以stdin方式获取内容，使用此配置生成新的image
    docker port <container> <container port> 查看本地哪个端口映射到container的指定端口，其实用docker ps 也可以看到

### docker文件存放目录

Docker实际上把所有东西都放到/var/lib/docker路径下了。


### [`doc from`](http://blog.csdn.net/fgf00/article/details/51893771)