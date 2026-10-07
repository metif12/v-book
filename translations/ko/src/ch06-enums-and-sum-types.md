# Chapter 6: Enum과 Sum Type

## Enum

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

## Sum Type

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

## 패턴 매칭

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

## 요약

이 장에서는 enum, sum type, 패턴 매칭에 대해 배웠습니다. 다음 장에서는 모듈과 패키지를 살펴보겠습니다.
