# 第 18 章：内存管理深入

## GC 模式

V 提供多种内存管理策略，每种适用于不同的用例。

| 模式 | 参数 | 用例 |
|------|------|----------|
| Boehm GC | `-gc boehm` | 通用 |
| 自动释放 | `-autofree` | 自动释放 |
| 无 | `-gc none` | 手动管理 |
| 预分配 | `-prealloc` | 竞技场分配 |

## 栈与堆

V 自动决定内存分配位置。小型、短生命周期的值保留在栈上。较大或逃逸的值放到堆上。

```v
fn stack_example() int {
    x := 42
    y := x * 2
    return y
}

fn heap_example() []int {
    data := []int{len: 100, init: 0}
    return data
}

fn main() {
    a := stack_example()
    b := heap_example()
    println(a)
    println(b.len)
}
```

## 自动释放模式

自动释放在变量离开作用域时自动释放内存。它对堆分配使用引用计数。

```v
fn create_user(name string) string {
    greeting := 'Hello, ${name}!'
    return greeting
}

fn main() {
    msg := create_user('World')
    println(msg)
}
```

## -gc none 和手动内存

使用 `-gc none` 时，V 禁用垃圾回收。你必须使用 `free` 手动管理内存。

```v
fn main() {
    mut data := []int{len: 1000, init: 0}
    for i in 0 .. 1000 {
        data[i] = i * 2
    }
    println(data[500])
    unsafe {
        data.free()
    }
}
```

## -prealloc 竞技场分配

预分配使用竞技场分配来提高紧循环中的性能。分配批量释放。

```v
fn process_items(count int) int {
    mut total := 0
    $if prealloc {
        for i in 0 .. count {
            total += i * i
        }
    } $else {
        for i in 0 .. count {
            total += i * i
        }
    }
    return total
}

fn main() {
    result := process_items(10000)
    println(result)
}
```

## 不安全代码

`unsafe` 块允许绕过 V 安全保证的操作，如指针运算和直接内存访问。

```v
fn main() {
    x := 42
    p := unsafe { &x }
    println(p)
    unsafe {
        q := p + 1
        println(q)
    }
}
```

### 指针运算

```v
fn main() {
    arr := [10, 20, 30, 40, 50]
    unsafe {
        p := &arr[0]
        first := p[0]
        second := p[1]
        third := p[2]
        println('${first} ${second} ${third}')
    }
}
```

## 性能调优

选择正确的内存管理模式可以显著影响性能。

### 对不同模式进行基准测试

```v
fn benchmark_allocations(iterations int) i64 {
    sw := i64(0)
    $if boehm ? {
        sw = i64(1)
    }
    $if autofree ? {
        sw = i64(2)
    }
    $if prealloc ? {
        sw = i64(3)
    }
    return sw
}

fn main() {
    mode := benchmark_allocations(1000000)
    println('Mode: ${mode}')
}
```

### 优化数据结构

```v
struct Point {
    x f64
    y f64
}

fn sum_points(points []Point) f64 {
    mut total := 0.0
    for p in points {
        total += p.x + p.y
    }
    return total
}

fn main() {
    points := []Point{len: 10000, init: Point{x: 1.0, y: 2.0}}
    result := sum_points(points)
    println(result)
}
```

## 小结

在本章中，你学习了内存管理模式、栈与堆分配、自动释放、手动内存管理、预分配、不安全代码和性能调优。在下一章中，我们将探讨工具链。
