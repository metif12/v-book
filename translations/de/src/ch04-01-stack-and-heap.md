# Stack und Heap

V entscheidet automatisch, ob auf dem Stack oder Heap allokiert wird:

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

- Schnelle Allokation und Deallokation
- Feste Größe zur Kompilierzeit
- Wird automatisch freigegeben, wenn der Gültigkeitsbereich endet

## Heap

- Dynamische Größe
- Langsamere Allokation
- Verwaltet durch GC oder Autofree

## Weiter

[Garbage Collection](ch04-02-garbage-collection.md)
