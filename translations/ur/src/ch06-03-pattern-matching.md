# پیٹرن میچنگ

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

## Match کی مکمل پیشکش

```v
enum Direction {
    north
    south
    east
    west
}

fn turn(d Direction) string {
    return match d {
        .north { 'turning north' }
        .south { 'turning south' }
        .east { 'turning east' }
        .west { 'turning west' }
    }
}
```

## اگلا

[باب ۷: ماڈیولز اور پیکجز](ch07-modules-and-packages.md)
