# الفصل 5: Structs

Structs هي طريقة V لتعريف أنواع بيانات مخصصة.

## تعريف Structs

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

## الدوال المرتبطة (Methods)

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

## Structs المضمنة

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

## محددات الوصول

الحقول خاصة افتراضياً. استخدم `pub` لجعلها عامة:

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

## الملخص

في هذا الفصل، تعلمت عن structs، الدوال المرتبطة، التضمين، ومحددات الوصول. في الفصل التالي، سنستكشف enums وأنواع الجمع.
