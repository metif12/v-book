# Değişkenler ve Değişkenlik

V'de değişkenler varsayılan olarak değişmezdir:

```v
fn main() {
    name := 'V'
    // name = 'Go'  // Hata: name değişmez

    mut count := 0
    count = 1  // Tamam: count değişkendir
    count++
    println(count)
}
```

## Tanımlama

Tanımlamak ve başlatmak için `:=` kullanın:

```v
x := 42
name := 'V'
is_ready := true
```

## Tip çıkarımı

V, tipleri başlatıcıdan çıkarır:

```v
a := 42      // int
b := 3.14    // f64
c := 'hello' // string
d := true    // bool
```

## Açık tipler

Tipleri açıkça belirtebilirsiniz:

```v
a := i64(42)
b := f32(3.14)
c := u8(255)
```

## Sonraki

[Veri Tipleri](ch03-02-data-types.md)
