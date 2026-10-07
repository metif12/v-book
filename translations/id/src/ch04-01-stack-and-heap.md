# Stack dan Heap

V secara otomatis memutuskan apakah akan mengalokasikan di stack atau heap:

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

- Alokasi dan dealokasi cepat
- Ukuran tetap saat compile time
- Otomatis dibebaskan ketika scope berakhir

## Heap

- Ukuran dinamis
- Alokasi lebih lambat
- Dikelola oleh GC atau autofree

## Berikutnya

[Garbage Collection](ch04-02-garbage-collection.md)
