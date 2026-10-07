# Hello, World!

创建一个名为 `main.v` 的文件：

```v
fn main() {
    println('Hello, World!')
}
```

运行它：

```bash
v run main.v
```

输出：

```
Hello, World!
```

## V 程序的结构

让我们来分析这个程序：

- `fn main()` — 每个 V 程序都从 `main` 函数开始。`fn` 关键字用于声明函数。
- `println(...)` — 一个内置函数，用于向标准输出打印一行。
- `'Hello, World!'` — 字符串字面量。V 使用单引号表示字符串。

## 编译与运行

`v run` 一步完成编译和运行。你也可以先编译：

```bash
v main.v
./main
```

## 下一步

[Hello, V!](ch01-03-hello-v.md)
