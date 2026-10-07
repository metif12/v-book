# 第13章：関数型機能

Vはクロージャと高次関数をサポートしています。

## クロージャ

```v
fn main() {
    add := fn (a int, b int) int {
        return a + b
    }
    println(add(2, 3))
}
```

## 高次関数

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

## 匿名関数

```v
fn main() {
    nums := [1, 2, 3, 4, 5]
    doubled := nums.map(fn (x int) int {
        return x * 2
    })
    println(doubled)
}
```

## まとめ

この章では、クロージャと高次関数について学びました。次の章では、並行性を見ていきます。
