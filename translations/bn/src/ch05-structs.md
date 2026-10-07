# অধ্যায় 5: struct

struct হল V-এর কাস্টম ডেটা টাইপ সংজ্ঞায়িত করার উপায়।

## struct সংজ্ঞায়িত করা

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

## মেথড

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

## এমবেডেড struct

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

## অ্যাক্সেস মডিফায়ার

ফিল্ডগুলো ডিফল্টভাবে প্রাইভেট। পাবলিক করতে `pub` ব্যবহার করুন:

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

## সারসংক্ষেপ

এই অধ্যায়ে আপনি struct, মেথড, এমবেডিং এবং অ্যাক্সেস মডিফায়ার সম্পর্কে শিখেছেন। পরবর্তী অধ্যায়ে আমরা enum এবং sum type শিখব।
