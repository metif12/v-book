# 模式匹配

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

## Match 穷尽性

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

## 下一步

[第 7 章：模块与包](ch07-modules-and-packages.md)
