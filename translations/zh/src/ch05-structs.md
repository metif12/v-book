# 第 5 章：结构体

结构体是 V 定义自定义数据类型的方式。

## 定义结构体

```v
struct Point {
    x int
    y int
}

fn main() {
    p := Point{x: 10, y: 20}
    println('(${p.x}, ${p.y})')
}
```

## 方法

```v
struct Point {
    x int
    y int
}

fn (p Point) str() string {
    return '(${p.x}, ${p.y})'
}

fn main() {
    p := Point{x: 10, y: 20}
    println(p.str())
}
```

## 内嵌结构体

```v
struct Point {
    x int
    y int
}

struct Circle {
    Point
    radius f64
}

fn main() {
    c := Circle{
        Point: Point{x: 0, y: 0}
        radius: 5.0
    }
    println('(${c.x}, ${c.y}) r=${c.radius}')
}
```

## 访问修饰符

字段默认是私有的。使用 `pub` 使其公开：

```v
struct User {
    name string
pub:
    age int
}

fn main() {
    u := User{name: 'Alice', age: 30}
    println(u.name)  // 正确：同一模块
    println(u.age)   // 正确：公开
}
```

## 小结

在本章中，你学习了结构体、方法、内嵌和访问修饰符。在下一章中，我们将探讨枚举与和类型。
