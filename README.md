# easyswoole_autoreload
通过crontab 自动重启easyswoole主服务，

每分钟执行一次脚本，自动检测主服务，发现各主文件变更后，借助crontab 自动重启的脚本，分享给有需要的同学。

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
