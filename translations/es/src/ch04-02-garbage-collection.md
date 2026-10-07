# Recolección de Basura

V usa un recolector de basura por defecto:

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

## Desactivar el GC

Para código crítico en rendimiento, puedes desactivar el GC:

```bash
v -gc none main.v
```

## Siguiente

[Autofree](ch04-03-autofree.md)
