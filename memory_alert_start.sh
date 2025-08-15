#!/bin/bash
# 内存监控启动脚本：每5秒执行一次检测，支持开机自启

# 定义监控脚本路径（请替换为你的memory_alert.sh实际路径）
MONITOR_SCRIPT="./memory_alert.sh"

# 检查监控脚本是否存在
if [ ! -f "$MONITOR_SCRIPT" ]; then
  echo "错误：未找到监控脚本 $MONITOR_SCRIPT"
  echo "请修改本脚本中的 MONITOR_SCRIPT 路径为实际位置"
  exit 1
fi

# 检查是否已有监控进程在运行
if [ -f "$HOME/.memory_monitor_pid" ]; then
  EXISTING_PID=$(cat "$HOME/.memory_monitor_pid")
  if ps -p "$EXISTING_PID" >/dev/null; then
    echo "监控进程已在运行（PID: $EXISTING_PID）"
    exit 0
  fi
fi

# 启动后台监控循环（每5秒执行一次）
echo "启动内存监控...每5秒检测一次"
(
  while true; do
    bash "$MONITOR_SCRIPT"
    sleep 5 # 间隔5秒
  done
) &

# 记录进程ID到文件，用于后续停止
echo $! >"$HOME/.memory_monitor_pid"
echo "监控已启动（PID: $(cat "$HOME/.memory_monitor_pid")）"

notify-send "男人只是因为内存超出 80%..." "就被管家打断了双腿!" --icon=dialog-information
