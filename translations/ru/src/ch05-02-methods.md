# Методы

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

## Изменяемые получатели

```v
struct Counter {
mut:
    count int
}

fn (mut c Counter) increment() {
    c.count++
}

fn main() {
    mut c := Counter{}
    c.increment()
    c.increment()
    println(c.count)
}
```

## Далее

[Встроенные структуры](ch05-03-embedded-structs.md)
