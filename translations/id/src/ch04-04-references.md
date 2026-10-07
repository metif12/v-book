# Referensi

Gunakan referensi untuk menghindari penyalinan data besar:

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

## Berikutnya

[Bab 5: Struct](ch05-structs.md)
