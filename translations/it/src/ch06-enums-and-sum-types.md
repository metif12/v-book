# Capitolo 6: Enum e Tipi Sum

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

## Tipi Sum

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

## Pattern Matching

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

## Riassunto

In questo capitolo, hai imparato i tipi enum, i tipi sum e il pattern matching. Nel prossimo capitolo, esploreremo i moduli e i pacchetti.
