# Referanslar

Büyük verilerin kopyalanmaktan kaçınmak için referanslar kullanın:

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

## Sonraki

[Bölüm 5: Struct'lar](ch05-structs.md)
