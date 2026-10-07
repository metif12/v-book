# Garbage Collection

V verwendet standardmäßig einen Garbage Collector:

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

## GC deaktivieren

Für leistungskritischen Code können Sie den GC deaktivieren:

```bash
v -gc none main.v
```

## Weiter

[Autofree](ch04-03-autofree.md)
