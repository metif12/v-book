# باب ۵: structs

structs حسب منشا ڈیٹا اقسام کی تعریف کرنے کا V کا طریقہ ہیں۔

## structs کی تعریف

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

## میتھڈز

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

## ایمبیڈڈ structs

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

## رسائی کی تعدیل کار

فیلڈز ڈیفالٹ طور پر نجی ہوتے ہیں۔ انہیں عوامی بنانے کے لیے `pub` استعمال کریں:

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

## خلاصہ

اس باب میں، آپ نے structs، میتھڈز، ایمبیڈنگ، اور رسائی کی تعدیل کار کے بارے میں سیکھا۔ اگلے باب میں، ہم enums اور سم ٹائپس کو دریافت کریں گے۔
