# 安装

## Windows

### 安装程序

从 [vlang.io/install](https://vlang.io/install.html) 下载最新安装程序并运行。

### PowerShell

```powershell
irm https://raw.githubusercontent.com/vlang/v/master/installer.ps1 | iex
```

### 手动安装

1. 从 [GitHub releases](https://github.com/vlang/v/releases) 下载最新版本。
2. 解压 zip 文件。
3. 将 `v` 目录添加到 PATH 环境变量中。

## macOS

### Homebrew

```bash
brew install vlang
```

### 安装脚本

```bash
curl -sSL https://raw.githubusercontent.com/vlang/v/master/installer.sh | bash
```

## Linux

### 安装脚本

```bash
curl -sSL https://raw.githubusercontent.com/vlang/v/master/installer.sh | bash
```

### Arch Linux

```bash
yay -S vlang
```

## 从源码构建

要从源码构建 V，你需要一个 C 编译器（gcc 或 clang）：

```bash
git clone https://github.com/vlang/v
cd v
make
```

在 Windows 上，使用 `win.bat` 代替 `make`。

## 验证

```bash
v version
```

## 下一步

[Hello, World!](ch01-02-hello-world.md)
