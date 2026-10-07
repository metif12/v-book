# Coleta de Lixo

V usa um coletor de lixo por padrão:

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

## Desabilitando GC

Para código crítico em desempenho, você pode desabilitar o GC:

```bash
v -gc none main.v
```

## Próximo

[Autofree](ch04-03-autofree.md)
