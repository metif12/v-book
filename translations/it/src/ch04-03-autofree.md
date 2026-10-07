# Autofree

V ha una modalità autofree che libera automaticamente la memoria:

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

## Avanti

[Riferimenti](ch04-04-references.md)
