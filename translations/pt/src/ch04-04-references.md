# Referências

Use referências para evitar copiar grandes volumes de dados:

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

## Próximo

[Capítulo 5: Structs](ch05-structs.md)
