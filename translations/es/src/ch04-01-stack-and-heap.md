# Stack y Heap

V decide automáticamente si asignar en el stack o en el heap:

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

- Asignación y liberación rápida
- Tamaño fijo en tiempo de compilación
- Se libera automáticamente cuando termina el ámbito

## Heap

- Tamaño dinámico
- Asignación más lenta
- Gestionado por GC o autofree

## Siguiente

[Recolección de Basura](ch04-02-garbage-collection.md)
