# Ramasse-miettes

V utilise un ramasse-miettes par défaut :

```v
fn main() {
    mut names := []string{}
    for i in 0 .. 100 {
        names << 'name ${i}'
    }
    // Memory is automatically freed when no longer referenced
    println(names.len)
}
```

## Désactiver le GC

Pour les code critiques en termes de performance, vous pouvez désactiver le GC :

```bash
v -gc none main.v
```

## Suivant

[Autofree](ch04-03-autofree.md)
