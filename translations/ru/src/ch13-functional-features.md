# Глава 13: Функциональные возможности

V поддерживает замыкания и функции высшего порядка.

## Замыкания

```v
fn main() {
    add := fn (a int, b int) int {
        return a + b
    }
    println(add(2, 3))
}
```

## Функции высшего порядка

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

## Анонимные функции

```v
fn main() {
    nums := [1, 2, 3, 4, 5]
    doubled := nums.map(fn (x int) int {
        return x * 2
    })
    println(doubled)
}
```

## Итоги

В этой главе вы узнали о замыканиях и функциях высшего порядка. В следующей главе мы рассмотрим конкурентность.
