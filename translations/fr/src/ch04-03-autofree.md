# Autofree

V dispose d'un mode autofree qui libère automatiquement la mémoire :

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

## Suivant

[Références](ch04-04-references.md)
