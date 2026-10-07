# 第 4 章：所有权与内存

V 采用了与许多语言不同的内存管理方式。V 不是单纯依赖手动内存管理或垃圾回收，而是提供了多种策略。

## 栈与堆

V 自动决定是在栈上还是堆上分配内存：

```v
fn main() {
    // 栈分配（小，固定大小）
    x := 42
    arr := [1, 2, 3]

    // 堆分配（大，动态）
    mut big := []int{}
    for i in 0 .. 1000 {
        big << i
    }

    println('${x} ${arr} ${big.len}')
}
```

## 垃圾回收

V 默认使用垃圾回收器。你不需要手动释放内存：

```v
fn main() {
    mut names := []string{}
    for i in 0 .. 100 {
        names << 'name ${i}'
    }
    // 内存不再被引用时自动释放
    println(names.len)
}
```

## 自动释放

V 有自动释放模式，当变量离开作用域时自动释放内存：

```bash
v -autofree main.v
```

```v
fn process() {
    mut data := []int{}
    for i in 0 .. 1000 {
        data << i
    }
    // data 在这里自动释放
}

fn main() {
    process()
    println('done')
}
```

## 引用

你可以使用引用来避免复制大量数据：

```v
fn modify(mut arr []int) {
    arr << 42
}

fn main() {
    mut data := [1, 2, 3]
    modify(mut data)
    println(data)
}
```

## 内存管理模式

| 模式 | 参数 | 描述 |
|------|------|-------------|
| GC（默认） | `-gc boehm` | Boehm 垃圾回收器 |
| 自动释放 | `-autofree` | 自动内存释放 |
| 无 | `-gc none` | 手动内存管理 |
| 预分配 | `-prealloc` | 竞技场分配 |

## 小结

在本章中，你学习了 V 的内存管理选项。在下一章中，我们将探讨结构体。
