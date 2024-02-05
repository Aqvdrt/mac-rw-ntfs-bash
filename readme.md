# Bash script for Mac OS with Apple chip to read and write NTFS hard drive.

[English](readme.md) | [中文](readme-zh.md)

The `ntfs.sh` script can change the NTFS hard drive on the Mac system (Apple M series chip) to a read-write mount mode, so that data can be directly written to the NTFS hard drive.This script is `free` and there is no need to download any paid software during use.
`Everytime` you insert the NTFS hard drive, you `need to execute` this script before you can write data to the hard drive.

## Preparation for the first run
- Set the computer's security policy to "Reduced Security" and allow user management of kernel extensions from identified developers.
  - Press and hold the `Touch ID` or `Power button` for at least 10 seconds until Loading startup options appears (for Apple chips).
  - Click `Options`-`Continue`-(upper left corner)`Utilities`-`Startup Security Utility`-`Security Policy`.
  - Select `Reduced Security`, check `Allow user management of kernel extensions from identified developers`, and click `OK`.
  - After the setting is successful, click the Apple logo in the upper left corner of the screen to `restart` the computer.
  - For specific steps, please refer to: https://support.apple.com/guide/mac-help/mchl768f7291/mac

- Before running this script for the first time, you need to run the following command to authorize this script (assuming the script name is ntfs.sh):
```bash
chmod +x ntfs.sh
```

## How to use the script
- The hard drive must first be inserted.
- Open (cd) the directory where the script is located and execute the script:
```bash
./ntfs.sh
```
- After the NTFS is successfully remounted, the directory where the Finder is located will be automatically opened.


## Sources
- [Change security settings on the startup disk of a Mac with Apple silicon](https://support.apple.com/guide/mac-help/mchl768f7291/mac)
- [mac OS use macfuse to enable NTFS write](https://www.cnblogs.com/qkcan/p/17473575.html)
- [Homebrew](https://brew.sh/)
- [osxfuse/osxfuse/NTFS 3G](https://github.com/osxfuse/osxfuse/wiki/NTFS-3G)

## License
[GNU Lesser General Public License v3.0](https://choosealicense.com/licenses/gpl-3.0/)