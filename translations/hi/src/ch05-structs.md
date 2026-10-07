# अध्याय 5: Structs

Structs V में कस्टम डेटा टाइप्स परिभाषित करने का तरीका हैं।

## Structs परिभाषित करना

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

## मेथड्स

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

## एम्बेडेड Structs

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

## एक्सेस मॉडिफायर

फ़ील्ड्स डिफ़ॉल्ट रूप से प्राइवेट होती हैं। उन्हें पब्लिक बनाने के लिए `pub` का उपयोग करें:

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

## सारांश

इस अध्याय में, आपने structs, मेथड्स, एम्बेडिंग, और एक्सेस मॉडिफायर के बारे में सीखा। अगले अध्याय में, हम enums और sum types का पता लगाएंगे।
