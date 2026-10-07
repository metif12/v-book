# Riferimenti

Usa i riferimenti per evitare di copiare grandi quantità di dati:

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

## Avanti

[Capitolo 5: Struct](ch05-structs.md)
