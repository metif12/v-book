# Variables and Mutability

In V, variables are immutable by default:

```v
fn main() {
    name := 'V'
    // name = 'Go'  // Error: name is immutable

    mut count := 0
    count = 1  // OK: count is mutable
    count++
    println(count)
}
```

## Declaration

Use `:=` to declare and initialize:

```v
x := 42
name := 'V'
is_ready := true
```

## Type inference

V infers types from the initializer:

```v
a := 42      // int
b := 3.14    // f64
c := 'hello' // string
d := true    // bool
```

## Explicit types

You can specify types explicitly:

```v
a := i64(42)
b := f32(3.14)
c := u8(255)
```

## Next

[Data Types](ch03-02-data-types.md)
