# অধ্যায় 6: enum এবং sum type

## enum

```v
enum Color {
    red
    green
    blue
}

fn main() {
    c := Color.red
    println(c)
    match c {
        .red { println('Red!') }
        .green { println('Green!') }
        .blue { println('Blue!') }
    }
}
```

## sum type

```v
type Shape = Circle | Rectangle

struct Circle {
    radius f64
}

struct Rectangle {
    width  f64
    height f64
}

fn area(s Shape) f64 {
    return match s {
        Circle { 3.14 * s.radius * s.radius }
        Rectangle { s.width * s.height }
    }
}

fn main() {
    c := Circle{radius: 5.0}
    r := Rectangle{width: 10.0, height: 20.0}
    println(area(c))
    println(area(r))
}
```

## প্যাটার্ন ম্যাচিং

```v
fn describe(x ?int) string {
    return if x != none {
        'value: ${x}'
    } else {
        'no value'
    }
}

fn main() {
    println(describe(42))
    println(describe(none))
}
```

## সারসংক্ষেপ

এই অধ্যায়ে আপনি enum, sum type এবং প্যাটার্ন ম্যাচিং সম্পর্কে শিখেছেন। পরবর্তী অধ্যায়ে আমরা module এবং প্যাকেজ শিখব।
