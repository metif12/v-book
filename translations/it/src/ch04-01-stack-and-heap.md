# Stack e Heap

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

## Stack

- Allocazione e deallocazione veloci
- Dimensione fissa in fase di compilazione
- Liberato automaticamente alla fine dello scope

## Heap

- Dimensione dinamica
- Allocazione più lenta
- Gestito da GC o autofree

## Avanti

[Garbage Collection](ch04-02-garbage-collection.md)
