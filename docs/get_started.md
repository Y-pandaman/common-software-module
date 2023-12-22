---
title: 快速入门指南
---
- [快速入门指南](#快速入门指南)
  - [预置条件](#预置条件)
  - [获取并编译 SMN 代码](#获取并编译-smn-代码)
  - [运行 SMN 代码](#运行-smn-代码)

# 快速入门指南

这份文档旨在帮助您使用 CMake 搭建 SMN 开发环境。我们建议每个开始使用 SMN 代码进行开发的人都至少完成一遍这个快速教程。

## 预置条件

在本教程中，编译并运行 SMN 代码需要：

1. 操作系统：Ubuntu 18.04 或更高版本
2. C++ 编译器：支持 C++14 的 C++ 编译器，例如 g++ 的 `7.5.0` 或更高版本
3. [Git](https://git-scm.com)：用于从 GitHub 上下载 SMN 代码
4. [CMake](https://cmake.org)：用于构建 SMN 代码，要求 `3.19` 或更高版本
5. [Colcon](https://github.com/colcon/colcon-core)：用于构建SMN代码，要求 `0.3.0-1` 或更高版本

   ```bash
   # 在 Ubuntu 或者 Debian 系统中安装 Colcon
   curl -s https://packagecloud.io/install/repositories/dirk-thomas/colcon/script.deb.sh | sudo bash
   sudo apt install python3-colcon-common-extensions
   ```
6. [OpenCV](https://opencv.org/releases/)：用于图像处理，要求 `3.2.0` 或更高版本

   ```bash
   # 在 Ubuntu 或者 Debian 系统中安装 OpenCV
   sudo apt install libopencv-dev
   ```
7. [GStreamer](https://gstreamer.freedesktop.org/download/)：用于视频流处理，要求 `1.14.5` 或更高版本

   ```bash
   # 在 Ubuntu 或者 Debian 系统中安装 GStreamer
   sudo apt-get install \
     libgstreamer1.0-dev \
     libgstreamer-plugins-base1.0-dev \
     libgstreamer-plugins-bad1.0-dev \
     gstreamer1.0-plugins-base \
     gstreamer1.0-plugins-good \
     gstreamer1.0-plugins-bad \
     gstreamer1.0-plugins-ugly \
     gstreamer1.0-libav \
     gstreamer1.0-tools \
     gstreamer1.0-rtsp \
     libgstreamer-plugins-base1.0-dev \
     libgstreamer-plugins-good1.0-dev \
     libgstreamer-plugins-bad1.0-dev \
     libgstrtspserver-1.0-dev
   ```
8. [fmt](https://github.com/fmtlib/fmt)：用于格式化输出，要求 `9.0.0` 或更高版本

   ```bash
   # 在较新版本的 Ubuntu 或者 Debian 系统中，可以通过 apt 安装 fmt
   sudo apt install libfmt-dev

   # 或者手动编译安装
   ```
9. [abseil-cpp](https://github.com/abseil/abseil-cpp)：用于字符串处理，要求 `lts_2023_01_25` 或更高版本
10. [Catch2](https://github.com/catchorg/Catch2)：用于单元测试，要求 `v3.2.1` 或更高版本
11. [ccache](https://github.com/ccache/ccache)：用于编译加速 ，要求 `3.4.1` 或更高版本

```bash
   # 在 Ubuntu 或者 Debian 系统中安装 ccache
   sudo apt install ccache
```

## 获取并编译 SMN 代码

```bash
# 1. 获取 SMN 代码
mkdir smn_ws
git clone https://github.com/Y-pandaman/common-software_module.git smn_ws/src/software_module_name

# 2. 编译 SMN 代码
cd smn_ws
# 2.1 在 PC 上使用 colcon 进行编译
colcon build \
  --cmake-clean-first --cmake-force-configure \
  --packages-select smn_cpp \
  --cmake-args \
  -DCMAKE_CXX_COMPILER_LAUNCHER=ccache \
  -DCMAKE_BUILD_TYPE=Release

# 2.2 在 PC 上使用 cmake 进行编译
cd src/sofaware_module_name
mkdir build && cd build
cmake ..
make -j$(nproc)
```

值得注意的是，在使用 `colcon`进行编译时：

1. 若仅需要编译 `smn_cpp`，可以添加 `--packages-select smn_cpp`选项，以减少编译时间
2. 若希望使用 `ccache`加速编译，可以添加 `--cmake-args -DCMAKE_CXX_COMPILER_LAUNCHER=ccache`选项
3. 若希望每次从头开始重新编译，可以添加 `--cmake-clean-first`与 `--cmake-force-configure`选项

## 运行 SMN 代码

若需要运行示例程序，可参考 [示例程序说明](./apps/README.md)。
