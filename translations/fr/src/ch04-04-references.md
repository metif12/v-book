# Références

Utilisez des références pour éviter de copier des données volumineuses :

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

## Suivant

[Chapitre 5 : Structs](ch05-structs.md)
