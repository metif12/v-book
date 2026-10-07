# struct সংজ্ঞায়িত করা

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

## আরম্ভ

```v
struct Point {
    x int
    y int
}

p := Point{x: 10, y: 20}
p2 := Point{10, 20}
```

## পরবর্তী

[মেথড](ch05-02-methods.md)
