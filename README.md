# 华联工具

这是一个主要为实现自身需求尝试开发的Flutter桌面端，目前只是测试Windows平台，其他平台暂未测试

## 支持什么功能？

- 支持开机启动
- 支持开机自动认证校园网
- 支持第一次使用时自动连接对应wifi

PS：自动连接wifi需要电脑支持netsh命令，否则无法奏效

- [下载地址](https://hlu.airsado.cn/)

# 更新记录

- 2020.02.27 1.0.0 发布
- 2020.02.28 1.0.1 1.修复开机启动设置开启后，关闭软件再打开还是关闭状态\n2.修复安装目录与开机启动路径不一致导致的软件无法正常开机启动问题
- 2020.02.28 1.0.2 1.优化软件体验，默认开启‘开机自启’、‘记住密码’的设置\n2.优化开机自启的配置逻辑\n
- 2020.02.28 1.0.3 1.修复疏忽导致的更新后无法打开软件\n2.修复”自动登录“、”记住密码“勾选但是失效的问题\n3.优化软件启动逻辑
- 2020.03.01 1.0.4 1.修复其他设备在线中，使用软件登录成功但没有联网\n2.优化修改首页界面并删除删除沉余代码\n3.进一步完善软件功能
- 2023.10.04 1.0.8 1.重写UI \n 2.重构程序结构，进行一定解耦 \n 3.实现了连接校园网wifi，无需输入密码

# 感谢以下项目

- [Flutter](https://hlu.airsado.cn/)
- [Dart](https://dart.cn/)