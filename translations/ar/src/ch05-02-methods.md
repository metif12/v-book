# الدوال المرتبطة (Methods)

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

## المُستقبِلات القابلة للتغيير

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

## التالي

[Structs المضمنة](ch05-03-embedded-structs.md)
