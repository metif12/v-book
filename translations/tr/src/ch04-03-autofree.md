# Autofree

V'nin belleği otomatik olarak serbest bırakan bir autofree modu vardır:

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

## Sonraki

[Referanslar](ch04-04-references.md)
