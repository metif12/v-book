# 第 3 章：基本概念

本章涵盖 V 中的通用编程概念：变量、数据类型、函数、注释和控制流。

## 变量与可变性

在 V 中，变量默认是不可变的。使用 `mut` 使其可变：

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

## 数据类型

V 有丰富的类型系统：

```v
fn main() {
    // 整数
    a := 42        // int
    b := i64(100)  // 64 位整数
    c := u8(255)   // 无符号 8 位

    // 浮点数
    pi := 3.14     // f64
    e := f32(2.71) // 32 位浮点数

    // 其他类型
    name := 'V'    // string
    is_ok := true  // bool
    letter := `A`  // rune（单个字符）

    println('${a} ${b} ${c}')
    println('${pi} ${e}')
    println('${name} ${is_ok} ${letter}')
}
```

## 函数

函数使用 `fn` 声明：

```v
fn add(a int, b int) int {
    return a + b
}

fn greet(name string) {
    println('Hello, ${name}!')
}

fn main() {
    result := add(2, 3)
    println(result)
    greet('World')
}
```

## 注释

```v
// 这是行注释

/* 这是
   块注释 */
```

## 控制流

### If

```v
fn main() {
    age := 25
    if age >= 18 {
        println('Adult')
    } else {
        println('Minor')
    }
}
```

### For 循环

```v
fn main() {
    // 遍历数组
    fruits := ['apple', 'banana', 'cherry']
    for fruit in fruits {
        println(fruit)
    }

    // 范围循环
    for i in 0 .. 5 {
        println(i)
    }
}
```

### Match

```v
fn main() {
    color := 'blue'
    match color {
        'red' { println('Red!') }
        'blue' { println('Blue!') }
        else { println('Other color') }
    }
}
```

## 小结

在本章中，你学习了 V 中的变量、数据类型、函数、注释和控制流。在下一章中，我们将探讨所有权和内存管理。
