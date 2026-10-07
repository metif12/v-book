# Çöp Toplama

V varsayılan olarak bir çöp toplayıcı kullanır:

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

## GC'yi devre dışı bırakma

Performans açısından kritik kod için GC'yi devre dışı bırakabilirsiniz:

```bash
v -gc none main.v
```

## Sonraki

[Autofree](ch04-03-autofree.md)
