# প্যাটার্ন ম্যাচিং

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

## Match সম্পূর্ণতা

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

## পরবর্তী

[অধ্যায় 7: module এবং প্যাকেজ](ch07-modules-and-packages.md)
