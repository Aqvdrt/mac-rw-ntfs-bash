# Mac电脑苹果芯片读写NTFS硬盘bash脚本

[English](readme.md) | [中文](readme-zh.md)

`ntfs.sh`脚本可以将Mac系统(苹果M系芯片)上的NTFS硬盘改成可读写的挂载方式，从而可以直接往NTFS硬盘写入数据。此脚本`免费`，使用过程中无需下载任何收费软件。
`每次`插入NTFS硬盘之后，都`需要执行此脚本`，才可以往硬盘中写入数据。

## 初次运行准备工作
- 将电脑的安全策略设置为“降低安全性”，并允许用户管理来自被认可开发者的内核扩展。
  - 首先将电脑关机。
  - 按住`触控ID或电源按钮`，至少10秒，直到出现`正在载入启动选项`（适用Apple芯片）。
  - 点按`选项`-`继续`-(左上角)`实用工具`-`启用安全性实用工具`-`安全策略`。
  - 选择`降低安全性`，勾选`允许用户管理来自被认可开发者的内核扩展`，点击`好`。
  - 设置成功之后，点击屏幕左上角的苹果标志`重启`电脑，重启即可
  - 具体步骤可参考：https://support.apple.com/guide/mac-help/mchl768f7291/mac

- 初次运行此脚本前，需要在`终端.app`运行以下指令授权此脚本(假设此脚本名称是"ntfs.sh")：
```bash
# 查看ntfs.sh所在目录
mdfind -name ntfs.sh
# 假设脚本位于 "/Users/mac/Desktop/ntfs.sh"
# 授权
chmod +x /Users/mac/Desktop/ntfs.sh
```

## 如何使用脚本
- `初次运行前`，请先完成[初次运行准备工作](#初次运行准备工作)。
- **[重要] 每次执行脚本之前，必须先插入硬盘**。
- 初次运行脚本时，需要安装必要的软件，请耐心等候。

### （推荐）双击运行脚本
- 首先将`ntfs.sh`脚本放到桌面；
- 然后`右键单击`脚本-选择`打开方式`-`其他`；
- 将启用方式改成：`所有应用程序`，并勾选`始终以此方式打开`；
- 在搜索栏输入：`terminal`，在结果中选择`终端.app`，最后点击右下角`打开`，此时脚本会自动执行；
- 以后每次只需要在桌面双击`ntfs.sh`脚本，就会自动执行；
- NTFS重新挂载成功之后，会自动打开Finder所在目录。


### （或者）在[终端.app]里面运行脚本
- 打开`终端.app`，进入(cd)脚本所在目录，执行脚本：
```bash
# 查看ntfs.sh所在目录
mdfind -name ntfs.sh
# 执行脚本，假设脚本位于 "/Users/mac/Desktop/ntfs.sh"
/Users/mac/Desktop/ntfs.sh
```
- NTFS重新挂载成功之后，会自动打开Finder所在目录。


## 参考资料
- [在搭载 Apple 芯片的 Mac 上更改启动磁盘的安全性设置](https://support.apple.com/guide/mac-help/mchl768f7291/mac)
- [mac 系统 安装macfuse 支持NTFS写入](https://www.cnblogs.com/qkcan/p/17473575.html)
- [Homebrew](https://brew.sh/)
- [osxfuse/osxfuse/NTFS 3G](https://github.com/osxfuse/osxfuse/wiki/NTFS-3G)

## 许可证
[GNU Lesser General Public License v3.0](https://choosealicense.com/licenses/gpl-3.0/)