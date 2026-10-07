# Yığın ve Yığın (Heap)

V, yığın mı yoksa heap mi tahsis edileceğini otomatik olarak belirler:

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

## Yığın (Stack)

- Hızlı tahsis ve serbest bırakma
- Derleme zamanında sabit boyut
- Kapsam sona erdiğinde otomatik olarak serbest bırakılır

## Yığın (Heap)

- Dinamik boyut
- Daha yavaş tahsis
- GC veya autofree tarafından yönetilir

## Sonraki

[Çöp Toplama](ch04-02-garbage-collection.md)
