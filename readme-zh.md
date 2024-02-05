# Mac电脑苹果芯片读写NTFS硬盘bash脚本

[English](readme.md) | [中文](readme-zh.md)

`ntfs.sh`脚本可以将Mac系统(苹果M系芯片)上的NTFS硬盘改成可读写的挂载方式，从而可以直接往NTFS硬盘写入数据。

## 初次运行准备工作
- 将电脑的安全策略设置为“降低安全性”，并允许用户管理来自被认可开发者的内核扩展。
  - 按住`触控ID或电源按钮`，至少10秒，直到出现`正在载入启动选项`（适用Apple芯片）。
  - 点按`选项`-`继续`-(左上角)`实用工具`-`启用安全性实用工具`-`安全策略`。
  - 选择`降低安全性`，勾选`允许用户管理来自被认可开发者的内核扩展`，点击`好`。
  - 设置成功之后，点击屏幕左上角的苹果标志`重启`电脑，重启即可
  - 具体步骤可参考：https://support.apple.com/guide/mac-help/mchl768f7291/mac

- 初次运行此脚本前，需要运行以下指令授权此脚本(假设此脚本名称是ntfs.sh)：
```bash
chmod +x ntfs.sh
```

## 如何使用脚本
- 首先必须插入硬盘。
- 打开(cd)脚本所在目录，执行脚本：
```bash
./ntfs.sh
```
- NTFS重新挂载成功之后，会自动打开Finder所在目录。


## 参考资料
- [在搭载 Apple 芯片的 Mac 上更改启动磁盘的安全性设置](https://support.apple.com/guide/mac-help/mchl768f7291/mac)
- [mac 系统 安装macfuse 支持NTFS写入](https://www.cnblogs.com/qkcan/p/17473575.html)
- [Homebrew](https://brew.sh/)
- [osxfuse/osxfuse/NTFS 3G](https://github.com/osxfuse/osxfuse/wiki/NTFS-3G)

## 许可证
[GNU Lesser General Public License v3.0](https://choosealicense.com/licenses/gpl-3.0/)