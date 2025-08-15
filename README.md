# 内存监控管家 (Memory Alert)

一个智能的内存监控工具，当内存使用率超过设定阈值时会自动发送桌面通知提醒用户。

## 特性

- 🚀 实时监控系统内存使用率
- ⚙️ 可配置的内存阈值（默认85%）
- 🔔 桌面通知提醒
- 🎯 支持开机自启动
- 🛠️ 简单的命令行控制（mal start/stop）
- 🖥️ 桌面应用集成

## 过程

### 核心代码

待补充...

### 打包过程

你这个目录结构已经差不多了，但还差几个关键点才能打包成能被 `apt` 安装的 `.deb`：

#### DEBIAN/control

确保 `DEBIAN/control` 里最少有：

```text
Package: work-memory-alert
Version: 1.0
Section: utils
Priority: optional
Architecture: all
Maintainer: xxx <you@example.com>
Description: Memory alert scripts
 一组内存告警脚本，用于监控系统内存状态。
 ...
```

#### 执行权限

`usr/local/bin` 里的脚本必须有可执行权限，`DEBIAN` 里的文件要可读。

#### 软件打包

在 `~/temp/work-memory-alert` 的上一级目录执行：

```bash
dpkg-deb --build work-memory-alert
```

会得到：

```
work-memory-alert.deb
```

#### 安装测试

```bash
sudo apt install ./work-memory-alert.deb
```

安装后，你的脚本会出现在：

```
/usr/local/bin/memory_alert.sh
/usr/local/bin/memory_alert_start.sh
/usr/local/bin/memory_alert_stop.sh
/usr/local/bin/memory_care.png
```

#### 卸载测试

```bash
sudo apt remove work-memory-alert # 控制文件中的唯一标识名称
```

会自动删除 `/usr/local/bin` 里的这些文件。

#### 发布测试

如果想直接 `apt install work-memory-alert` 而不是 `apt install ./xxx.deb`，那可以加一个**本地 apt 源**，以后直接更新、安装。

