# 第 19 章：工具链

## v fmt

按照官方风格指南格式化 V 源代码。使用 `-w` 就地写入更改。

```bash
v fmt -w .
```

### 格式化单个文件

```bash
v fmt -w main.v
```

### 检查格式但不写入

```bash
v fmt -check .
```

## v doc

从 V 源文件生成文档。默认输出 HTML。

```bash
v doc .
```

### 为特定模块生成文档

```bash
v doc -o docs/ .
```

## v profiler

分析程序执行以识别性能瓶颈。

```bash
v -profile profile.txt run main.v
```

### 分析性能输出

```bash
v profile profile.txt
```

## v test

运行当前目录或指定文件中的单元测试。

```bash
v test .
```

### 运行特定测试

```bash
v test -run TestName .
```

### 带覆盖率运行测试

```bash
v test -cover .
```

## v check

对 V 代码执行静态分析，检查错误、警告和风格问题。

```bash
v check .
```

### 检查单个文件

```bash
v check main.v
```

## 交叉编译

V 可以从单台机器为不同的操作系统和架构编译代码。

```bash
v -os windows main.v
v -os linux main.v
v -os macos main.v
```

### 指定架构

```bash
v -os linux -arch amd64 main.v
v -os linux -arch arm64 main.v
```

### 为嵌入式目标交叉编译

```bash
v -os embedded -arch arm main.v
```

## v doctor

显示关于 V 安装的诊断信息，包括编译器版本、操作系统和配置。

```bash
v doctor
```

## v up

将 V 编译器更新到最新版本。

```bash
v up
```

### 更新到特定版本

```bash
v up --version 0.5.2
```

## 小结

在本章中，你学习了 V 工具链生态系统：`v fmt` 用于格式化、`v doc` 用于文档、`v profiler` 用于性能分析、`v test` 用于测试、`v check` 用于静态分析、交叉编译、`v doctor` 用于诊断以及 `v up` 用于自更新。在下一章中，我们将构建最终项目。
