# 变量与可变性

在 V 中，变量默认是不可变的：

```v
fn main() {
    name := 'V'
    // name = 'Go'  // 错误：name 是不可变的

    mut count := 0
    count = 1  // 正确：count 是可变的
    count++
    println(count)
}
```

## 声明

使用 `:=` 声明和初始化：

```v
x := 42
name := 'V'
is_ready := true
```

## 类型推断

V 从初始化表达式推断类型：

```v
a := 42      // int
b := 3.14    // f64
c := 'hello' // string
d := true    // bool
```

## 显式类型

你可以显式指定类型：

```v
a := i64(42)
b := f32(3.14)
c := u8(255)
```

## 下一步

[数据类型](ch03-02-data-types.md)
