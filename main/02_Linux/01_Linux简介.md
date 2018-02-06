Linux
=======
by `groovyguang`
## 

## 一切皆文件

![](./img/linuxFile.png)

    01、 /bin★ (/usr/bin 、 /usr/local/bin)
        是Binary的缩写, 这个目录存放着最经常使用的命令
	02、/sbin (/usr/sbin、/usr/local/sbin)
	   s就是Super User的意思，这里存放的是系统管理员使用的系统管理程序
	03、/home ★
	    存放普通用户的主目录，在Linux中每个用户都有一个自己的目录，一般该目录名是以用户的账号命名的。
	04、/root ★
	    该目录为系统管理员，也称作超级权限者的用户主目录。
	05、/lib
	    系统开机所需要最基本的动态连接共享库，其作用类似于Windows里的DLL文件。几乎所有的应用程序都需要用到这些共享库。
	06、 /lost+found
	    这个目录一般情况下是空的，当系统非法关机后，这里就存放一些文件。
	07、/etc ★
	     所有的系统管理所需要的配置文件和子目录
	08、/usr ★
	    这是一个非常重要的目录，用户的很多应用程序和文件都放在这个目录下，类似于
	         Windows下的program files目录
	09、/boot ★
	    这里存放的是启动Linux时使用的一些核心文件，包括一些连接文件以及镜像文件,自己的安装别放在这里
	10、/proc
	    这个目录是一个虚拟的目录，它是系统内存的映射，我们可以通过直接访问这个目录来获取系统信息。
	11、/srv
	    service缩写，该目录存放一些服务启动之后需要提取的数据。
	12、/sys
	    这是Linux2.6内核的一个很大的变化。该目录下安装了2.6内核中新出现的一个文件系统sysfs
	13、/tmp
	    这个目录是用来存放一些临时文件的。
	14、/dev ★
	    类似于Windows的设备管理器，把所有的硬件用文件的形式存储。
	15、/media ★
	    Linux系统会自动识别一些设备，例如U盘，光驱等等，当识别后，Linux会把识别的设备挂载到这个目录下。
	16、/mnt
	    系统提供该目录是为了让用户临时挂载别的文件系统的，我们可以将外部的存储挂载在/mnt/上，然后进入该目录就可以查看里面的内容了。
	17、/opt ★
	    这是给主机额外安装软件所摆放的目录。比如你安装一个ORACLE数据库则就可以放到这个目录下。默认是空的
	18、/usr/local   ★
	    这是另一个给主机额外安装软件所摆放的目录。一般是通过编译源码方式安装的程序
	19、/var   ★
	    这个目录中存放着在不断扩充着的东西，我们习惯将那些经常被修改的目录放在这个目录下。包括各种日志文件
	20、/selinux
	    SELinux是一种安全子系统,它能控制程序只能访问特定文件


## vi/vim 编辑
![](./img/vimSimplifiedChineseVersion.gif)

<div>
<span><div><div><span><img src="01_linux__files/Image [1].png" type="image/png" data-filename="" style="font-size: 14pt; color: rgb(255, 0, 0);"/></span></div><div><br/></div><div><br/></div><div><span><font style="font-size: 14pt; color: rgb(255, 0, 0);">vim编辑器分为三种模式 一般模式，编辑模式，命令模式</font></span></div><div><br/></div><div><span><font style="font-size: 14pt; color: rgb(255, 0, 0);">一般模式</font></span></div><div><span><font style="font-size: 14pt;">      打开文旦的默认模式，主要负责查看，和一些基础的修剪</font></span></div>


<table style="border-collapse: collapse; min-width: 100%;"><colgroup><col style="width: 336px;"></col><col style="width: 412px;"></col></colgroup><tbody><tr><td height="39" style="height: 29.2pt; background-color: rgb(251, 207, 214); border: 1px solid rgb(201, 166, 171); width: 336px; padding: 8px;"><div style="line-height: normal; margin: 0pt 0in; text-indent: 0in; text-align: left; direction: ltr; unicode-bidi: embed; word-break: normal;"><span style="line-height: normal; text-indent: 0in; direction: ltr; unicode-bidi: embed; word-break: normal; font-size: 18pt; font-weight: bold;">删除光标当前行，</span><span style="line-height: normal; text-indent: 0in; direction: ltr; unicode-bidi: embed; word-break: normal; font-size: 18pt; font-family: Calibri; font-weight: bold;">dd</span><span style="line-height: normal; text-indent: 0in; direction: ltr; unicode-bidi: embed; word-break: normal; font-size: 18pt; font-weight: bold;">，</span></div></td><td style="background-color: rgb(251, 207, 214); border: 1px solid rgb(201, 166, 171); width: 412px; padding: 8px;"><div style="margin-top: 0pt; margin-bottom: 0pt; margin-left: 0in; text-align: left; direction: ltr; unicode-bidi: embed; word-break: normal;"><span style="direction: ltr; unicode-bidi: embed; word-break: normal; font-size: 18pt;">移动到行头，</span><span style="direction: ltr; unicode-bidi: embed; word-break: normal; font-size: 18pt; font-family: Calibri;">shift+^</span></div></td></tr><tr><td height="39" style="height: 29.2pt; background-color: rgb(240, 209, 246); border: 1px solid rgb(192, 167, 197); width: 336px; padding: 8px;"><div style="line-height: normal; margin: 0pt 0in; text-indent: 0in; text-align: left; direction: ltr; unicode-bidi: embed; word-break: normal;"><span style="line-height: normal; text-indent: 0in; direction: ltr; unicode-bidi: embed; word-break: normal; font-size: 18pt; font-weight: bold;">删除</span><span style="line-height: normal; text-indent: 0in; direction: ltr; unicode-bidi: embed; word-break: normal; font-size: 18pt; font-family: Calibri; font-weight: bold;">n</span><span style="line-height: normal; text-indent: 0in; direction: ltr; unicode-bidi: embed; word-break: normal; font-size: 18pt; font-family: 宋体; font-weight: bold;">行</span> <span style="line-height: normal; text-indent: 0in; direction: ltr; unicode-bidi: embed; word-break: normal; font-size: 18pt; font-family: Calibri; font-weight: bold;">，</span><span style="line-height: normal; text-indent: 0in; direction: ltr; unicode-bidi: embed; word-break: normal; font-size: 18pt; font-family: Calibri; font-weight: bold;"> </span> <span style="line-height: normal; text-indent: 0in; direction: ltr; unicode-bidi: embed; word-break: normal; font-size: 18pt; font-family: Calibri; font-weight: bold;">dnd</span></div></td><td style="background-color: rgb(240, 209, 246); border: 1px solid rgb(192, 167, 197); width: 412px; padding: 8px;"><div style="margin-top: 0pt; margin-bottom: 0pt; margin-left: 0in; text-align: left; direction: ltr; unicode-bidi: embed; word-break: normal;"><span style="direction: ltr; unicode-bidi: embed; word-break: normal; font-size: 18pt;">移动到行尾，</span><span style="direction: ltr; unicode-bidi: embed; word-break: normal; font-size: 18pt; font-family: Calibri;">shift+$</span></div></td></tr><tr><td height="67" style="height: 50.4pt; background-color: rgb(221, 209, 243); border: 1px solid rgb(177, 167, 194); width: 336px; padding: 8px;"><div style="margin-top: 0pt; margin-bottom: 0pt; margin-left: 0in; text-align: left; direction: ltr; unicode-bidi: embed; word-break: normal;"><span style="direction: ltr; unicode-bidi: embed; word-break: normal; font-size: 18pt; font-weight: bold;">撤销上一步，</span><span style="direction: ltr; unicode-bidi: embed; word-break: normal; font-size: 18pt; font-family: Calibri; font-weight: bold;">u</span></div></td><td style="background-color: rgb(221, 209, 243); border: 1px solid rgb(177, 167, 194); width: 412px; padding: 8px;"><div style="line-height: normal; margin: 0pt 0in; text-indent: 0in; text-align: left; direction: ltr; unicode-bidi: embed; word-break: normal;"><span style="line-height: normal; text-indent: 0in; direction: ltr; unicode-bidi: embed; word-break: normal; font-size: 18pt; font-weight: bold;">移动到页尾，</span><span style="line-height: normal; text-indent: 0in; direction: ltr; unicode-bidi: embed; word-break: normal; font-size: 18pt; font-family: Calibri; font-weight: bold;">shift+g</span></div><div style="margin-top: 0pt; margin-bottom: 0pt; margin-left: 0in; text-align: left; direction: ltr; unicode-bidi: embed; word-break: normal;"></div></td></tr><tr><td height="39" style="height: 29.2pt; background-color: rgb(204, 215, 234); border: 1px solid rgb(163, 172, 187); width: 336px; padding: 8px;"><div style="margin-top: 0pt; margin-bottom: 0pt; margin-left: 0in; text-align: left; direction: ltr; unicode-bidi: embed; word-break: normal;"><span style="direction: ltr; unicode-bidi: embed; word-break: normal; font-size: 18pt;">复制光标当前行，</span><span style="direction: ltr; unicode-bidi: embed; word-break: normal; font-size: 18pt; font-family: Calibri;">yy</span></div></td><td style="background-color: rgb(204, 215, 234); border: 1px solid rgb(163, 172, 187); width: 412px; padding: 8px;"><div style="margin-top: 0pt; margin-bottom: 0pt; margin-left: 0in; text-align: left; direction: ltr; unicode-bidi: embed; word-break: normal;"><span style="direction: ltr; unicode-bidi: embed; word-break: normal; font-size: 18pt;">移动到页头，数字</span><span style="direction: ltr; unicode-bidi: embed; word-break: normal; font-size: 18pt; font-family: Calibri;">1+shift+g</span></div></td></tr><tr><td height="39" style="height: 29.2pt; background-color: rgb(205, 230, 249); border: 1px solid rgb(164, 184, 199); width: 336px; padding: 8px;"><div style="margin-top: 0pt; margin-bottom: 0pt; margin-left: 0in; text-align: left; direction: ltr; unicode-bidi: embed; word-break: normal;"><span style="direction: ltr; unicode-bidi: embed; word-break: normal; font-size: 18pt;">粘贴，</span><span style="direction: ltr; unicode-bidi: embed; word-break: normal; font-size: 18pt; font-family: Calibri;">p</span></div></td><td style="background-color: rgb(205, 230, 249); border: 1px solid rgb(164, 184, 199); width: 412px; padding: 8px;"><div style="margin-top: 0pt; margin-bottom: 0pt; margin-left: 0in; text-align: left; direction: ltr; unicode-bidi: embed; word-break: normal;"><span style="direction: ltr; unicode-bidi: embed; word-break: normal; font-size: 18pt;">移动到目标行，数字</span><span style="direction: ltr; unicode-bidi: embed; word-break: normal; font-size: 18pt; font-family: Calibri;">N+shift+g</span></div></td></tr><tr><td height="39" style="height: 29.2pt; background-color: rgb(255, 230, 151); border: 1px solid rgb(204, 184, 121); width: 336px; padding: 8px;"><div style="margin-top: 0pt; margin-bottom: 0pt; margin-left: 0in; text-align: left; direction: ltr; unicode-bidi: embed; word-break: normal;"><span style="direction: ltr; unicode-bidi: embed; word-break: normal; font-size: 18pt; font-weight: bold;">删除一个字母，</span><span style="direction: ltr; unicode-bidi: embed; word-break: normal; font-size: 18pt; font-family: Calibri; font-weight: bold;">x</span> <span style="direction: ltr; unicode-bidi: embed; word-break: normal; font-size: 18pt; font-family: Calibri; font-weight: bold;">,X</span></div></td><td style="background-color: rgb(255, 230, 151); border: 1px solid rgb(204, 184, 121); width: 412px; padding: 8px;"><div style="margin-top: 0pt; margin-bottom: 0pt; margin-left: 0in; text-align: left; direction: ltr; unicode-bidi: embed; word-break: normal;"></div></td></tr><tr><td height="39" style="height: 29.2pt; background-color: rgb(205, 237, 216); border: 1px solid rgb(164, 190, 173); width: 336px; padding: 8px;"><div style="margin-top: 0pt; margin-bottom: 0pt; margin-left: 0in; text-align: left; direction: ltr; unicode-bidi: embed; word-break: normal;"><span style="direction: ltr; unicode-bidi: embed; word-break: normal; font-size: 18pt;">删除一个词，</span><span style="direction: ltr; unicode-bidi: embed; word-break: normal; font-size: 18pt; font-family: Calibri;">dw</span></div></td><td style="background-color: rgb(205, 237, 216); border: 1px solid rgb(164, 190, 173); width: 412px; padding: 8px;"><div style="margin-top: 0pt; margin-bottom: 0pt; margin-left: 0in; text-align: left; direction: ltr; unicode-bidi: embed; word-break: normal;"></div></td></tr><tr><td height="39" style="height: 29.2pt; background-color: rgb(254, 222, 193); border: 1px solid rgb(203, 178, 154); width: 336px; padding: 8px;"><div style="line-height: normal; margin: 0pt 0in; text-indent: 0in; text-align: left; direction: ltr; unicode-bidi: embed; word-break: normal;"><span style="line-height: normal; text-indent: 0in; direction: ltr; unicode-bidi: embed; word-break: normal; font-size: 18pt;">复制一个词，</span><span style="line-height: normal; text-indent: 0in; direction: ltr; unicode-bidi: embed; word-break: normal; font-size: 18pt; font-family: Calibri;">yw</span></div></td><td style="background-color: rgb(254, 222, 193); border: 1px solid rgb(203, 178, 154); width: 412px; padding: 8px;"><div style="margin-top: 0pt; margin-bottom: 0pt; margin-left: 0in; text-align: left; direction: ltr; unicode-bidi: embed; word-break: normal;"></div></td></tr></tbody></table><div><br/></div><div><span style="font-size: 14pt; color: rgb(255, 0, 0);">编辑模式</span></div> 