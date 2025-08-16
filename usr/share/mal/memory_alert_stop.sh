#!/bin/bash
# 内存监控停止脚本：关闭后台运行的监控任务

PID_FILE="$HOME/.memory_monitor_pid"

# 检查是否有监控进程在运行
if [ ! -f "$PID_FILE" ]; then
  echo "没有正在运行的内存监控进程"
  exit 1
fi

MONITOR_PID=$(cat "$PID_FILE")

# 检查进程是否存在
if ! ps -p "$MONITOR_PID" >/dev/null; then
  echo "监控进程已停止（残留PID文件已清理）"
  rm -f "$PID_FILE"
  exit 0
fi

# 终止进程并清理PID文件
kill "$MONITOR_PID"
rm -f "$PID_FILE"

if [ $? -eq 0 ]; then
  echo "内存监控已停止（PID: $MONITOR_PID）"
else
  echo "停止监控失败，请手动终止进程 $MONITOR_PID"
fi

notify-send "管家！管家我好想你阿管家~" "qwq 内存管家你一定要幸福..." --icon=dialog-information
