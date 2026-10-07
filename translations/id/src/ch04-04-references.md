# References

Use references to avoid copying large data:

```v
fn modify(mut arr []int) {
    arr << 42
}

fn main() {
    mut data := [1, 2, 3]
    modify(mut data)
    println(data)
}
```

## Next

[Chapter 5: Structs](ch05-structs.md)
