#!/bin/bash

case "$1" in
start)
  /usr/local/bin/mal/memory_alert_start.sh # 生产环境
  # ./memory_alert_start.sh # 测试环境
  ;;
stop)
  /usr/local/bin/mal/memory_alert_stop.sh # 生产环境
  # ./memory_alert_stop.sh # 测试环境
  ;;
*)
  echo "用法: mal {start | stop} 启动管家或停止管家"
  exit 1
  ;;
esac
