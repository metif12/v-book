# Garbage Collection

V usa un garbage collector per impostazione predefinita:

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

## Disabilitare il GC

Per codice critico per le prestazioni, puoi disabilitare il GC:

```bash
v -gc none main.v
```

## Avanti

[Autofree](ch04-03-autofree.md)
