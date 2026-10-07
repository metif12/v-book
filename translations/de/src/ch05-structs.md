# Kapitel 5: Structs

Structs sind in V die Möglichkeit, eigene Datentypen zu definieren.

## Structs definieren

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

## Methoden

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

## Eingebettete Structs

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

## Zugriffsmodifikatoren

Felder sind standardmäßig privat. Verwenden Sie `pub`, um sie öffentlich zu machen:

```v
struct User {
    name string
pub:
    age int
}

fn main() {
    u := User{name: 'Alice', age: 30}
    println(u.name)  // OK: same module
    println(u.age)   // OK: public
}
```

## Zusammenfassung

In diesem Kapitel haben Sie Structs, Methoden, Einbettung und Zugriffsmodifikatoren kennengelernt. Im nächsten Kapitel untersuchen wir Enums und Sum Types.
