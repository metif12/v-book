# Pile et tas

V décide automatiquement d'allouer sur la pile ou le tas :

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

## Pile

- Allocation et désallocation rapides
- Taille fixe au moment de la compilation
- Automatiquement libérée à la fin de la portée

## Tas

- Taille dynamique
- Allocation plus lente
- Géré par le GC ou autofree

## Suivant

[Ramasse-miettes](ch04-02-garbage-collection.md)
