# Autofree

V tem um modo autofree que libera memória automaticamente:

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

## Próximo

[Referências](ch04-04-references.md)
