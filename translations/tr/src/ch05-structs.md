# Bölüm 5: Struct'lar

Struct'lar, V'nin özel veri tipleri tanımlama yoludur.

## Struct Tanımlama

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

## Metotlar

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

## Gömülü Struct'lar

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

## Erişim Belirleyiciler

Alanlar varsayılan olarak özeldir. Herkese açık yapmak için `pub` kullanın:

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

## Özet

Bu bölümde struct'lar, metotlar, gömme ve erişim belirleyicileri hakkında bilgi edindiniz. Sonraki bölümde enum'ları ve toplam tipleri inceleyeceğiz.
