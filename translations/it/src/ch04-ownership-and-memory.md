# Capitolo 4: Ownership e Memoria

V adotta un approccio diverso alla gestione della memoria rispetto a molti linguaggi. Invece della gestione manuale della memoria o della sola garbage collection, V offre più strategie.

## Stack e Heap

V decide automaticamente se allocare sullo stack o sull'heap:

```v
fn main() {
    // Stack-allocated (small, fixed size)
    x := 42
    arr := [1, 2, 3]

    // Heap-allocated (large, dynamic)
    mut big := []int{}
    for i in 0 .. 1000 {
        big << i
    }

    println('${x} ${arr} ${big.len}')
}
```

## Garbage Collection

V usa un garbage collector per impostazione predefinita. Non è necessario liberare la memoria manualmente:

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

## Autofree

V ha una modalità autofree che libera automaticamente la memoria quando le variabili escono dallo scope:

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

## Riferimenti

Puoi usare i riferimenti per evitare di copiare grandi quantità di dati:

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

## Modalità di gestione della memoria

| Modalità | Flag | Descrizione |
|----------|------|-------------|
| GC (predefinita) | `-gc boehm` | Garbage collector Boehm |
| Autofree | `-autofree` | Liberazione automatica della memoria |
| Nessuna | `-gc none` | Gestione manuale della memoria |
| Prealloc | `-prealloc` | Allocazione arena |

## Riassunto

In questo capitolo, hai imparato le opzioni di gestione della memoria di V. Nel prossimo capitolo, esploreremo gli struct.
