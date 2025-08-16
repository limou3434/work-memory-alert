# 内存监控管家 (Memory Alert)

一个智能的内存监控工具，当内存使用率超过设定阈值时会自动发送桌面通知提醒用户。

## 特性

- 🚀 实时监控系统内存使用率
- ⚙️ 可配置的内存阈值（默认 80%）
- 🔔 桌面通知提醒
- 🎯 支持开机自启动
- 🛠️ 简单的命令行控制（mal start/stop）
- 🖥️ 桌面应用集成

## 过程

### 规范过程

- 核心可执行文件（最好软连接，并且最好只有一个）放在 `/usr/bin/`，这样所有的用户都可以加载指令到全局进行使用(原因是 /usr/bin 一定在所有用户的 PATH 里，安装后立即全局可用)。几乎所有常见命令（`git、docker、kubectl、python3`）都在 `/usr/bin`。
- 三方库文件可以放 `/usr/lib/<项目名>/`
- 资源文件、辅助脚本可以放 `/usr/share/<项目名>/`
- 桌面软件配置可以放在 `/usr/share/applications/<项目名>/`
- 桌面图表图片可以放在 `/usr/share/icon/hicolor/256x256/apps/<项目名>.png`
- 配置文件可以放 `/etc/<项目名>/config.toml`

这样方便系统管理员统一管理。

### 核心代码

```shell
[drwxrwxrwx]  work-memory-alert
├── [drwxr-xr-x]  DEBIAN
│   ├── [-rwxr-xr-x]  control
│   ├── [-rwxr-xr-x]  postinst
│   ├── [-rwxr-xr-x]  postrm
│   └── [-rwxr-xr-x]  prerm
├── [drwxrwxr-x]  etc
│   └── [drwxrwxr-x]  mal
│       └── [-rw-r--r--]  config.toml
├── [-rwxrwxrwx]  README.md
└── [drwxrwxrwx]  usr
    ├── [drwxrwxr-x]  bin
    │   └── [-rwxr-xr-x]  mal
    ├── [drwxrwxr-x]  lib
    │   └── [drwxrwxr-x]  mal
    └── [drwxrwxr-x]  share
        ├── [drwxrwxr-x]  applications
        │   └── [-rw-rw-r--]  mal.desktop
        ├── [drwxrwxr-x]  icon
        │   └── [drwxrwxr-x]  hicolor
        └── [drwxrwxr-x]  mal
            ├── [-rwxr-xr-x]  mal.sh
            ├── [-rwxrwxr-x]  memory_alert.sh
            ├── [-rwxrwxr-x]  memory_alert_start.sh
            └── [-rwxrwxr-x]  memory_alert_stop.sh

12 directories, 12 files
```

### 打包过程

脚本必须有对应要求的权限，在父目录执行打包指令。

```bash
dpkg-deb --build work-memory-alert
```

会得到：

```
work-memory-alert.deb
```

### 安装测试

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

### 卸载测试

```bash
sudo apt remove work-memory-alert # 控制文件中的唯一标识名称
```

会自动删除 `/usr/local/bin` 里的这些文件。

### 发布测试

如果想直接 `apt install work-memory-alert` 而不是 `apt install ./xxx.deb`，那可以加一个**本地 apt 源**，以后直接更新、安装。可以借助 `GitHub Pages + apt 仓库索引` 来实现。
