# Garbage Collection

V menggunakan garbage collector secara default:

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

## Menonaktifkan GC

Untuk kode yang kritis terhadap performa, Anda dapat menonaktifkan GC:

```bash
v -gc none main.v
```

## Berikutnya

[Autofree](ch04-03-autofree.md)
