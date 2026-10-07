# Memformat dengan v fmt

V memiliki formatter kode bawaan:

```bash
v fmt -w .
```

Flag `-w` menulis perubahan kembali ke file. Tanpa flag tersebut, formatter mencetak ke stdout.

## Contoh

Sebelum:

```v
fn main(){
println( 'hello' )
}
```

Setelah `v fmt`:

```v
fn main() {
    println('hello')
}
```

## Berikutnya

[Menguji dengan v test](ch02-04-testing.md)
