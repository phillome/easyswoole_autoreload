# easyswoole_autoreload
## 背景
easyswoole虽然自带了热更新脚本，但只能更新work进程，master和manager进程并不会更新，

这个脚本就是解决这一问题的
通过crontab 自动重启easyswoole主服务

每分钟执行一次脚本，自动检测主服务，发现根目录下各文件变更后，
借助crontab 自动重启的脚本，分享给有需要的同学。

原理为每分钟判断文件大小 是否有变化，
任何一个文件大小有变化，则触发重启脚本。

## 优点：
1. 通过shell 来 启动进程和关闭进程，不用受php 的安全函数exec等限制
2. 部署到客户服务器后，每次变更代码，1分钟后，自动重启,新改的功能立即生效
3. 可以指定php版本号，如果没有指定，默认7.2 执行

## 使用方法
1. 放置 check.sh 脚本到easyswooke的根目录
2. 添加定时任务，1分钟一次，指令为： 
<pre>
* * * * *  cd /www/wwwroot/xxx.com/ && bash ./check.sh 72
</pre>


## 注意
1. 脚本中php 的路径 要结合自己的情况替换真实的路径，脚本中的路径是宝塔系统的路径
2. 目前脚本只检测了根目录下的文件变更，比如 dev.php produce.php easyswoole 等， 没有检测vendor的变更 



## 待改进点
1. 支持平滑重启
2. 目前是根据文件大小变化来触发，感觉通过修改时间判断更合理
3. 支持双机备份
4. crontab的替代方案，可以考虑supervisor


#### PS.
shell脚本不熟，是边学边试出来的，写的可能不规范，任何改进，各位大神尽管 pull我，我会尽快合并上来 造福大家
