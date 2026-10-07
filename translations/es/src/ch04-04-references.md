# Referencias

Usa referencias para evitar copiar datos grandes:

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

## Siguiente

[Capítulo 5: Structs](ch05-structs.md)
