#!/bin/bash

function start_server() {
  phpversion=$1
  if [[ -n "$phpversion" ]]; then
    curPath=$(cd `dirname $0`; pwd)
    echo "停止旧服务..."
    /www/server/php/$phpversion/bin/php $curPath/jiasu stop
    sleep 2
    ulimit -c unlimited
    echo "重新启动新服务..."
    /www/server/php/$phpversion/bin/php $curPath/jiasu start d
  else
    echo "check.sh后面 缺少php版本号（如71 72等）,默认按72处理"
    start_server 72
  fi
}

hasChanged=0; #文件是否有变更 ，默认为否
if [ -f Temp/old.files ];then
  #$5 是文件大小  $9 是文件名  , Temp/new.file 和 Temp/old.file 保存的是根目录下的文件变更
  ls -l | grep ^- | awk '{print $5,$9}' > Temp/new.files
  CurRow=1
  LastRow=`cat Temp/new.files | wc -l`
  while [ $CurRow -le $LastRow ]
  do
    # $1 是第一列，文件大小
    for x in `awk 'NR=='$CurRow' {print $1}' Temp/new.files`
      do
        for y in `awk 'NR=='$CurRow' {print $1}' Temp/old.files`
          do
            if [ "$x" != "$y" ];then
              hasChanged=1;
              echo "发现文件变更 , 重新生成文件指纹..."
              ls -l | grep ^- | awk '{print $5,$9}' > Temp/old.files
              start_server $1
            fi
          done
      done
    ((CurRow++))
  done

  #如果没有变更，则检查是否存在，如果不存在，则启动
  if [ $hasChanged -eq 0 ]; then
    count=`ps -fe |grep "SwooleJiasu" | grep -v "grep" | grep "Queue" | wc -l`
    echo "当前Swoole队列进程 $count "
    if [ $count -lt 1 ]; then
      start_server $1
    fi
  fi
else
  #完全是第一次，直接生成文件，并开启服务
  ls -l | grep ^- | awk '{print $5,$9}' > Temp/old.files
  start_server $1
fi


