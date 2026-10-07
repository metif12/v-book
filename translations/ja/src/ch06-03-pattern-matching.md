# パターンマッチング

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

## Matchの網羅性

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

## 次へ

[第7章：モジュールとパッケージ](ch07-modules-and-packages.md)
