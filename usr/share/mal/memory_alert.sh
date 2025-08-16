#!/bin/bash
# 内存阈值（可修改为 80、90 等）
THRESHOLD=80

# 从/proc/meminfo获取内存信息
MEM_TOTAL=$(grep MemTotal /proc/meminfo | awk '{print $2}')
MEM_AVAILABLE=$(grep MemAvailable /proc/meminfo | awk '{print $2}')

# 检查是否成功获取内存数据
if [ -z "$MEM_TOTAL" ] || [ -z "$MEM_AVAILABLE" ]; then
  echo "无法获取内存信息"
  exit 1
fi

# 计算已使用内存百分比
USED_MEM=$((MEM_TOTAL - MEM_AVAILABLE))
MEM_USAGE=$((USED_MEM * 100 / MEM_TOTAL))

# 如果占用超过阈值，发送带系统警告图标的通知
if [ "$MEM_USAGE" -gt "$THRESHOLD" ]; then
  # 使用系统自带的警告图标
  export DISPLAY=:0
  notify-send "内存占用过高，小心别崩了哥们，要被管家打断双腿了..." "当前内存使用率：$MEM_USAGE%" --icon=dialog-warning
fi
