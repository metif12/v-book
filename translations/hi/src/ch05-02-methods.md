# मेथड्स

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

## म्यूटेबल रिसीवर

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

## अगला

[एम्बेडेड Structs](ch05-03-embedded-structs.md)
