# Definiendo Structs

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

## Inicialización

```v
struct Point {
    x int
    y int
}

p := Point{x: 10, y: 20}
p2 := Point{10, 20}
```

## Siguiente

[Métodos](ch05-02-methods.md)
