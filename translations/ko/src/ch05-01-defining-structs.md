# Struct 정의하기

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

## 초기화

```v
struct Point {
    x int
    y int
}

p := Point{x: 10, y: 20}
p2 := Point{10, 20}
```

## 다음

[메서드](ch05-02-methods.md)
