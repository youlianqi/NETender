#!/usr/bin/env bash

set -euo pipefail

build_flag="--release"
output_dir=""

help_info() {
  echo "
Build the NERoom addons for Windows.

Options:
  -d    Compile in debug mode
  -o    Output directory
  -h    Display this help and exit.
  "
}

while getopts 'o:dh' flag
do
    case "${flag}" in
        d)
            build_flag="--debug"
            ;;
        o)
            output_dir="${OPTARG}"
            ;;
        h)
           help_info
           exit 0
           ;;
    esac
done


#if [ -n "$output_dir" ]; then
#  output_dir=$(realpath $output_dir)
#fi

echo '🚀 building TenderExample (universal) on Windows'
echo '🚀 -------------------------------------------------------'
echo '🚀 build flag: ' $build_flag ''
echo '🚀 output dir: ' $output_dir ''
echo '🚀 -------------------------------------------------------'


echo "build TenderExample start ..."


#解压netender-sdk
echo "解压libnode.zip"
unzip -o NETender_Windows_SDK/netender-sdk/bin/libnode.zip -d NETender_Windows_SDK/netender-sdk/bin

# shellcheck disable=SC2164
#cd "cpp-lib/room-kit"
echo "TenderExample clean cache ..."
# 使用强制删除参数，并允许错误继续执行
rm -rf build-release/ TenderExample-win32-x64/ || true
# 如果存在.vs目录（Visual Studio缓存）可能被锁定，单独处理
echo "尝试清理可能被锁定的Visual Studio缓存文件..."
if [ -d "build-release/.vs" ]; then
  rm -rf build-release/.vs/ > /dev/null 2>&1 || true
  echo "注意：如果有Visual Studio缓存文件无法删除，这通常不会影响构建过程"
fi
#
echo " build TenderExample win32-x64 ..."
##win32-x64

#cmake -Bbuild-release -G"Visual Studio 17 2022" -DCMAKE_GENERATOR_PLATFORM=x64 -DCMAKE_BUILD_TYPE=Release \
#cmake -Bbuild-release -G"Visual Studio 16 2019" -DCMAKE_GENERATOR_PLATFORM=x64 -DCMAKE_BUILD_TYPE=Release \
cmake -Bbuild-release -G"Visual Studio 17 2022" -DCMAKE_GENERATOR_PLATFORM=x64 -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_INSTALL_PREFIX=TenderExample-win32-x64 \
      -DBUILD_TESTING=ON
cmake --build build-release --config Release --target install

# 执行Windows版的Qt部署工具windeployqt
# 首先检查是否设置了QT_PATH环境变量，如果没有，使用默认路径
if [ -z "${QT_PATH+x}" ]; then
  echo "警告: QT_PATH 环境变量未设置，尝试使用默认路径"
  QT_PATH="C:\Qt\6.5.3\msvc2019_64"
fi

# 将Windows路径格式转换为bash可识别的格式
QT_PATH_BASH=$(echo "$QT_PATH" | sed 's/\\/\//g')
echo "使用Qt路径: $QT_PATH_BASH"

# 执行windeployqt工具
$QT_PATH_BASH/bin/windeployqt.exe TenderExample-win32-x64/bin/TenderExample.exe

echo "Qt依赖已成功部署到目标目录"

pwd
# 复制必要的动态链接库
cp -Rf "NETender_Windows_SDK/netender-sdk/runtime/index.js" "TenderExample-win32-x64/bin" 2>/dev/null || echo "⚠️  无法复制index.js文件"

# 检查netender-sdk/bin目录是否存在，存在则复制
if [[ -d "NETender_Windows_SDK/netender-sdk/bin" ]]; then
  cp -Rf "NETender_Windows_SDK/netender-sdk/bin"/* "TenderExample-win32-x64/bin" 2>/dev/null || echo "⚠️  netender-sdk/bin文件拷贝失败，但继续执行后续命令"
else
  echo "⚠️  netender-sdk/bin目录不存在，但继续执行后续命令"
fi

pwd
# 检查netender-sdk/runtime目录是否存在，存在则复制
if [[ -d "NETender_Windows_SDK/netender-sdk/runtime" ]]; then
  cp -Rf "NETender_Windows_SDK/netender-sdk/runtime"/* "TenderExample-win32-x64/bin/" 2>/dev/null
  if [[ $? -eq 0 ]]; then
    echo "✅ NETender_Windows_SDK/netender-sdk/runtime"
  else
    echo "⚠️  NETender_Windows_SDK/netender-sdk/runtime目录文件拷贝过程中出现错误，但继续执行后续命令"
  fi
else
  echo "⚠️  NETender_Windows_SDK/netender-sdk/runtime目录不存在，但继续执行后续命令"
fi

echo "build TenderExample win32-x64 done ..."
