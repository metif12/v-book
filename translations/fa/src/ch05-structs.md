# فصل ۵: struct ها

struct ها راه V برای تعریف انواع داده سفارشی هستند.

## تعریف struct ها

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

## متدها

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

## struct های تودرتو

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

## اصلاح‌کننده‌های دسترسی

فیلدها به صورت پیش‌فرض خصوصی هستند. از `pub` برای عمومی کردن آن‌ها استفاده کنید:

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

## خلاصه

در این فصل، درباره struct ها، متدها، تودرتو و اصلاح‌کننده‌های دسترسی یاد گرفتید. در فصل بعد، به enum ها و انواع جمع می‌پردازیم.
