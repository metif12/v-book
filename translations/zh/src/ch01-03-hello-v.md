# Hello, V!

让我们看一个更有趣的例子：

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

## 字符串插值

V 使用 `${...}` 进行字符串插值。`${...}` 中的任何表达式都会被求值并转换为字符串：

```v
fn main() {
    a := 42
    b := 3.14
    println('a = ${a}, b = ${b}')
    println('a + 10 = ${a + 10}')
}
```

## 变量

使用 `:=` 声明和初始化变量：

```v
fn main() {
    name := 'V'
    version := 0.5
    is_awesome := true
    println('${name} v${version} is awesome: ${is_awesome}')
}
```

## 下一步

[第 2 章：构建项目](ch02-building-a-project.md)
