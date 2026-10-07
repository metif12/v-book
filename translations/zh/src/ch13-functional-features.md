# 第 13 章：函数式特性

V 支持闭包和高阶函数。

## 闭包

```v
fn main() {
    add := fn (a int, b int) int {
        return a + b
    }
    println(add(2, 3))
}
```

## 高阶函数

```v
fn apply(f fn (int) int, x int) int {
    return f(x)
}

fn main() {
    double := fn (x int) int {
        return x * 2
    }
    println(apply(double, 5))
}
```

## 匿名函数

```v
fn main() {
    nums := [1, 2, 3, 4, 5]
    doubled := nums.map(fn (x int) int {
        return x * 2
    })
    println(doubled)
}
```

## 小结

在本章中，你学习了闭包和高阶函数。在下一章中，我们将探讨并发。
