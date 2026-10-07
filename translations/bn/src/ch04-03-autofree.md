# Autofree

V has an autofree mode that automatically frees memory:

```bash
v -autofree main.v
```

```v
fn process() {
    mut data := []int{}
    for i in 0 .. 1000 {
        data << i
    }
    // data is automatically freed here
}

fn main() {
    process()
    println('done')
}
```

## Next

[References](ch04-04-references.md)
