# Autofree

V memiliki mode autofree yang secara otomatis membebaskan memori:

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

## Berikutnya

[Referensi](ch04-04-references.md)
