# easyswoole_autoreload
## 背景
easyswoole虽然自带了热更新脚本，但只能更新work进程，master和manager进程并不会更新
这个脚本就是解决这一问题的
通过crontab 自动重启easyswoole主服务

每分钟执行一次脚本，自动检测主服务，发现根目录下 各文件变更后，借助crontab 自动重启的脚本，分享给有需要的同学。


## 优点：
1. 通过shell 来 启动进程和关闭进程，不用受php 的安全函数exec等限制
2. 部署到客户服务器后，每次变更代码，1分钟后，自动重启
3. 可以指定php版本号，如果没有指定，默认7.2 执行

## 使用方法
1. 放置此脚本到easyswooke的根目录
2. 添加定时任务，1分钟一次，指令为： 
<pre>
* * * * *  cd /www/wwwroot/xxx.com/ && bash ./check.sh 72
</pre>

## 注意
1. 脚本中php 的路径 要结合自己的情况替换真实的路径
2. 目前脚本只检测了根目录下的文件变更，没有检测vendor的变更 
