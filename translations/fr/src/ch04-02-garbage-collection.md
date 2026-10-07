# Garbage Collection

V uses a garbage collector by default:

```v
fn main() {
    mut names := []string{}
    for i in 0 .. 100 {
        names << 'name ${i}'
    }
    // Memory is automatically freed when no longer referenced
    println(names.len)
}
```

## Disabling GC

For performance-critical code, you can disable GC:

```bash
v -gc none main.v
```

## Next

[Autofree](ch04-03-autofree.md)
