# 第 1 章：入门

让我们开始你的 V 学习之旅！有很多东西要学，但每段旅程都始于一小步。在本章中，你将学习如何：

- 在你的系统上安装 V
- 编写 "Hello, World!" 程序
- 使用 V 编译器及其命令
- 创建一个 V 项目

## 安装

V 可以安装在 Windows、macOS 和 Linux 上。最简单的方式是使用安装脚本：

### Windows

从 [vlang.io/install](https://vlang.io/install.html) 下载并运行安装程序，或者使用 PowerShell：

```powershell
irm https://raw.githubusercontent.com/vlang/v/master/installer.ps1 | iex
```

### macOS

```bash
brew install vlang
```

或者使用安装脚本：

```bash
curl -sSL https://raw.githubusercontent.com/vlang/v/master/installer.sh | bash
```

### Linux

```bash
curl -sSL https://raw.githubusercontent.com/vlang/v/master/installer.sh | bash
```

### 从源码构建

要从源码构建 V：

```bash
git clone https://github.com/vlang/v
cd v
make
```

## 验证安装

安装完成后，验证 V 是否正常工作：

```bash
v version
```

你应该会看到类似输出：

```
V 0.5.2
```

## Hello, World!

现在让我们编写第一个 V 程序。创建一个名为 `main.v` 的文件：

```v
fn main() {
    println('Hello, World!')
}
```

运行它：

```bash
v run main.v
```

你应该会看到：

```
Hello, World!
```

恭喜！你已经编写并运行了你的第一个 V 程序。

## Hello, V!

让我们看一个稍微有趣的例子：

```v
fn main() {
    name := 'V'
    println('Hello, ${name}!')
    println('${name} is a great language.')
}
```

运行它：

```bash
v run main.v
```

输出：

```
Hello, V!
V is a great language.
```

## V 编译器

V 编译器通过 `v` 命令调用。常用命令：

| 命令 | 描述 |
|---------|-------------|
| `v run file.v` | 编译并运行 V 文件 |
| `v file.v` | 将 V 文件编译为可执行文件 |
| `v fmt file.v` | 格式化 V 文件 |
| `v test .` | 运行当前目录中的测试 |
| `v doc .` | 生成文档 |
| `v doctor` | 诊断 V 安装状态 |

## 小结

在本章中，你学习了如何安装 V、编写 "Hello, World!" 程序以及使用 V 编译器。在下一章中，我们将学习如何组织 V 项目。
