# Глава 5: Структуры

Структуры — это способ V определять пользовательские типы данных.

## Определение структур

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

## Методы

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

## Встроенные структуры

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

## Модификаторы доступа

Поля по умолчанию приватные. Используйте `pub`, чтобы сделать их публичными:

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

## Итоги

В этой главе вы узнали о структурах, методах, встраивании и модификаторах доступа. В следующей главе мы рассмотрим перечисления и суммирующие типы.
