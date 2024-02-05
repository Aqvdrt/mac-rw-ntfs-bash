#!/bin/bash
# charset=utf-8
# @author: aqvdrt
# @date: 20240206
# 功能：在搭载Apple芯片的Mac上，取消NTFS硬盘默认的只读挂载方式，改成可读写的挂载方式。
# 
# 【重要】执行此脚本的前置条件：
#   1.将安全策略设置为“降低安全性”，并允许用户管理来自被认可开发者的内核扩展。具体步骤参考：https://support.apple.com/guide/mac-help/mchl768f7291/mac
#       - 按住触控ID或电源按钮，至少10秒，直到出现“正在载入启动选项”（适用Apple芯片）。
#       - 点按“选项”-“继续”-(左上角)“实用工具”-“启用安全性实用工具”-“安全策略”。
#       - 选择[降低安全性]，勾选“允许用户管理来自被认可开发者的内核扩展”，点击[好]。
#       - 设置成功之后，点击屏幕左上角的苹果标志重启电脑，重启即可
#   2.初次运行此脚本前，需要运行以下指令授权此脚本(假设此脚本名称是ntfs.sh)：`chmod +x ntfs.sh`
#   3.必须要先插入硬盘再执行此脚本.
# 
# 其他说明：
#   - 该功能需要借助第三方软件，此脚本会自动检查或安装这些软件：homebrew,macfuse,ntfs-3g-mac。
#   - (可选)如果在中国brew安装速度太慢，可以尝试修改brew镜像源：https://ken.io/note/macos-homebrew-install-and-configuration


# =============以下是需要执行的指令================

# 第一步：检查是否有只读的NTFS硬盘
if mount | grep ntfs | grep read-only
then
    echo " "
else
    echo "---当前不存在只读方式的NTFS硬盘.---"
    echo "---No read-only NTFS hard drive found.---"
    mount | grep -E 'ntfs|macfuse'
    exit
fi

# 第二步：确保所需环境已经安装
echo "[重要] 请确保安全策略已设置为“降低安全性”，并允许用户管理来自被认可开发者的内核扩展。"
echo "[IMPORTANT] Make sure the security options is set to 'Reduced Security', and allow user management of kernel extensions from identified developers"
echo "[重要] 要先将硬盘插入到电脑且识别成功，才可以重新挂载成功。"
echo "[IMPORTANT] The hard drive must be connected to the computer and recognized successfully before it can be remounted successfully."
# 关闭系统的Gatekeeper安全功能，才能运行从非官方来源（如App Store和已知开发者）安装的应用程序
sudo spctl --master-disable 
# 检查homebrew，如果不存在就安装
if ! command -v brew &> /dev/null
then
    echo "[Homebrew]尚未安装，即将开始自动安装。官网：https://brew.sh/"
    echo "[Homebrew] is not installed. It'll start installing soon. website: https://brew.sh/"
    # 使用官网的脚本自动安装homebrew
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    # 全局配置brew使其生效
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    echo "[Homebrew]已经安装。"
    echo "[Homebrew] is installed"
fi

# 检查 brew 中是否已安装 "macfuse"
if grep -q "macfuse" <<< "$(brew list)"
then
    echo "[macfuse]已安装"
    echo "[macfuse] is installed"
else
    echo "[macfuse]尚未安装，即将开始自动安装"
    echo "[macfuse] is not installed. It'll start installing soon."
    brew install --cask macfuse
fi

# 检查 brew 中是否已安装 "ntfs-3g-mac"
if grep -q "ntfs-3g-mac" <<< "$(brew list)"
then
    echo "[ntfs-3g-mac]已安装"
    echo "[ntfs-3g-mac] is installed"
else
    echo "[ntfs-3g-mac]尚未安装，即将开始自动安装"
    echo "[ntfs-3g-mac] is not installed. It'll start installing soon."
    brew tap gromgit/homebrew-fuse
    brew install ntfs-3g-mac
fi

# 第三步：开始重新挂载硬盘
echo "============读写NTFS的环境已准备好============"
echo "============It's ready to change NTFS mount method============"
echo "开始重新挂载NTFS硬盘，将只读硬盘改成读写方式，成功之后会自动打开finder"
echo "Starting to change NTFS to read-write mode. Finder will be opened once succeed."
mount | grep ntfs | grep read-only | while read -r line;
do
    # line: /dev/disk4s1 on /Volumes/EXTERNAL_USB (ntfs, local, nodev, nosuid, read-only, noowners, noatime, nobrowse)
    ((index++))
    echo "【第${index}个NTFS设备】------------------:"
    echo "【${index}-NTFS device】------------------:"
    echo "原始挂载方式:"${line}
    echo "Original mount:"${line}
    # 提取设备真实地址
    device_path=`echo $line | awk '{print$1}'`
    echo "设备真实地址:"${device_path}
    echo "Device real path:"${device_path}
    # 提取设备挂载地址
    mount_path=`echo $line | awk '{print$3}'`
    echo "设备挂载地址:"${mount_path}
    echo "Device mount path:"${mount_path}
    # 提取设备挂载的根目录
    mount_dir=`dirname $mount_path`
    # 提取设备挂载名称
    mount_name=`basename $mount_path`
    echo "设备挂载名称:"${mount_name}
    echo "Device mount name:"${mount_name}
    # 取消原有的硬盘挂载方式
    sudo umount $device_path
    # 以可读写方式重新挂载硬盘
    sudo -S $(which mount_ntfs) ${device_path} ${mount_path} # 此命令可以成功修改硬盘文件内容
    # sudo -S $(which ntfs-3g) ${device_path} ${mount_path} -o local -o allow_other -o auto_xattr -o volname=${mount_name} # 此命令无法成功修改硬盘文件内容
    echo "新设备[${mount_name}]已可读写！"
    echo "即将自动打开finder (${mount_path})..."
    echo "Hard drive [${mount_name}] is allowed to write and read!"
    echo "Opening finder (${mount_path})..."
    # 打开硬盘所挂载的根目录
    open ${mount_dir}
    echo '----------------------------------'
    echo " "
done 
