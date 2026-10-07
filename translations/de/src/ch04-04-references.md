# Referenzen

Verwenden Sie Referenzen, um das Kopieren großer Datenmengen zu vermeiden:

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

## Weiter

[Kapitel 5: Structs](ch05-structs.md)
