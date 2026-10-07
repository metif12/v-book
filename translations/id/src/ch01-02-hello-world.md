# Hello, World!

Buat file bernama `main.v`:

```v
fn main() {
    println('Hello, World!')
}
```

Jalankan:

```bash
v run main.v
```

Output:

```
Hello, World!
```

## Anatomi program V

Mari uraikan program tersebut:

- `fn main()` — Setiap program V dimulai dengan fungsi `main`. Kata kunci `fn` mendeklarasikan sebuah fungsi.
- `println(...)` — Fungsi bawaan yang mencetak baris ke stdout.
- `'Hello, World!'` — Literal string. V menggunakan tanda kutip tunggal untuk string.

## Kompilasi vs menjalankan

`v run` mengompilasi dan menjalankan dalam satu langkah. Anda juga bisa mengompilasi terlebih dahulu:

```bash
v main.v
./main
```

## Berikutnya

[Hello, V!](ch01-03-hello-v.md)
