# 第 12 章：I/O 项目：构建 CLI 工具

在本章中，我们将构建一个简单的命令行工具，用于读取文件并统计其行数、单词数和字符数。

## 项目设置

```bash
mkdir wordcount
cd wordcount
v init
```

## 实现

```v no_run
import os

fn count(text string) (int, int, int) {
    lines := text.split('\n').len
    words := text.split(' ').len
    chars := text.len
    return lines, words, chars
}

fn main() {
    if os.args.len < 2 {
        println('Usage: wordcount <file>')
        exit(1)
    }

    path := os.args[1]
    content := os.read_file(path) or {
        println('Failed to read file: ${path}')
        exit(1)
    }

    lines, words, chars := count(content)
    println('Lines: ${lines}')
    println('Words: ${words}')
    println('Chars: ${chars}')
}
```

## 运行

```bash
v run . main.v
```

## 小结

在本章中，你构建了一个命令行工具。在下一章中，我们将探讨函数式特性。
