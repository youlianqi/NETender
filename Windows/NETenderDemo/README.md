# NETender SDK Windows Demo

## 项目概述

- 这是一个基于网易云信NETender SDK技术的Windows版本远程在线音视频评标室解决方案的示例应用。
- NETender SDK 是网易会议招采场景专用的音视频SDK，提供了招采会议场景下的核心接口服务。
- 本示例程序演示了如何使用NETender SDK在Windows平台上实现完整的招采会议功能。

## 环境要求

- 开发环境：Windows 10/11
- 构建工具：CMake 3.5或更高版本
- Qt框架：Qt 5或Qt 6（推荐Qt 6.x.x）
- 编译器：支持C++17的Visual Studio（推荐Visual Studio 2019或更高版本）

## 安装和运行

### 开发环境配置

1. **安装CMake**
   - 从官网下载并安装CMake 3.5或更高版本
   - 确保CMake已添加到系统环境变量

2. **安装Qt**
   - 从Qt官网下载并安装Qt 5或Qt 6
   - 建议安装Visual Studio对应的Qt版本（如msvc2019_64）

3. **安装Visual Studio**
   - 确保安装了C++开发组件和Windows SDK

### 项目构建

1. **准备NETender SDK**
   - 确保`NETender_Windows_SDK`目录已正确放置在项目根目录下
   - 检查SDK目录结构是否包含`include`、`lib`和`bin`等必要文件夹

2. **配置Qt路径**
   - 方法1：设置系统环境变量`QT_PATH`指向Qt安装目录（例如：`C:\Qt\6.x.x\msvc2019_64`）
   - 方法2：在CMake命令行中指定Qt路径

3. **使用生成项目脚本**
   ```cmd
   #解压 NETender_Windows_SDK/netender-sdk/bin/libnode.zip
   sh build_for_windows.sh
   ```

4. **编译项目**
   - 打开生成的Visual Studio解决方案
   - 选择Release配置
   - 生成解决方案

### 运行程序

1. 确保将NETender SDK的运行时库文件（.dll）复制到可执行文件所在目录
2. 运行生成的TenderExample.exe可执行文件

## 功能说明

本示例程序提供了完整的招采会议功能演示，包括但不限于：

- SDK初始化与账户管理
- 会议创建与加入
- 音频管理（麦克风、扬声器控制）
- 视频管理（摄像头控制、视频预览）
- 屏幕共享功能
- 成员管理
- 聊天室功能
- 会议邀请功能
- 预会议管理
- 安全管理
- 等候室管理

## 开发人员注意事项

1. **SDK路径配置**
   - 确保`NETender_Windows_SDK`目录结构正确，包含必要的头文件和库文件

2. **Qt版本兼容性**
   - 项目支持Qt 5和Qt 6，但推荐使用Qt 6以获得更好的性能和兼容性

3. **Visual Studio版本**
   - 确保使用的Visual Studio版本与安装的Qt版本兼容

4. **运行时依赖**
   - 运行程序时，需要确保所有必要的DLL文件都在正确的位置

5. **构建脚本**
   - 项目提供了`build_for_windows.sh`脚本，可以根据需要修改为批处理文件使用

6. **功能测试**
   - 程序提供了日志功能，可以查看操作日志和调试信息
   - 首次使用时，需要先初始化SDK，然后进行其他操作

## 许可证

本示例程序仅供演示和学习使用，具体许可证请参考NETender SDK的相关协议。
