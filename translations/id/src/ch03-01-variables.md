# Variabel dan Mutabilitas

Dalam V, variabel bersifat immutable secara default:

```v
fn main() {
    name := 'V'
    // name = 'Go'  // Error: name is immutable

    mut count := 0
    count = 1  // OK: count is mutable
    count++
    println(count)
}
```

## Deklarasi

Gunakan `:=` untuk mendeklarasikan dan menginisialisasi:

```v
x := 42
name := 'V'
is_ready := true
```

## Inferensi tipe

V menyimpulkan tipe dari initializer:

```v
a := 42      // int
b := 3.14    // f64
c := 'hello' // string
d := true    // bool
```

## Tipe eksplisit

Anda dapat menentukan tipe secara eksplisit:

```v
a := i64(42)
b := f32(3.14)
c := u8(255)
```

## Berikutnya

[Tipe Data](ch03-02-data-types.md)
