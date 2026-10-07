# Capitolo 5: Struct

Gli struct sono il modo di V per definire tipi di dato personalizzati.

## Definire Struct

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

## Metodi

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

## Struct Incorporate

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

## Modificatori di Accesso

I campi sono privati per impostazione predefinita. Usa `pub` per renderli pubblici:

```v
struct User {
    name string
pub:
    age int
}

fn main() {
    u := User{name: 'Alice', age: 30}
    println(u.name)  // OK: stesso modulo
    println(u.age)   // OK: pubblico
}
```

## Riassunto

In questo capitolo, hai imparato gli struct, i metodi, l'incorporamento e i modificatori di accesso. Nel prossimo capitolo, esploreremo i tipi enum e sum.
