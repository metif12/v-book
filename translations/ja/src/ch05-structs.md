# 第5章：struct

structはVでカスタムデータ型を定義する方法です。

## structの定義

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

## メソッド

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

## 埋め込みstruct

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

## アクセス修飾子

フィールドはデフォルトでプライベートです。パブリックにするには`pub`を使用します：

```v
struct User {
    name string
pub:
    age int
}

fn main() {
    u := User{name: 'Alice', age: 30}
    println(u.name)  // OK: 同じモジュール
    println(u.age)   // OK: パブリック
}
```

## まとめ

この章では、struct、メソッド、埋め込み、アクセス修飾子について学びました。次の章では、enumとsum型を見ていきます。
