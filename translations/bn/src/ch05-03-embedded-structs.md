# এমবেডেড struct

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

## পরবর্তী

[অ্যাক্সেস মডিফায়ার](ch05-04-access-modifiers.md)
