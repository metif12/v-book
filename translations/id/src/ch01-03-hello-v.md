# Hello, V!

Mari lihat contoh yang lebih menarik:

```v
fn main() {
    name := 'V'
    println('Hello, ${name}!')
    println('${name} is a great language.')
}
```

Jalankan:

```bash
v run main.v
```

Output:

```
Hello, V!
V is a great language.
```

## Interpolasi string

V menggunakan `${...}` untuk interpolasi string. Setiap ekspresi di dalam `${...}` dievaluasi dan dikonversi ke string:

```v
fn main() {
    a := 42
    b := 3.14
    println('a = ${a}, b = ${b}')
    println('a + 10 = ${a + 10}')
}
```

## Variabel

Gunakan `:=` untuk mendeklarasikan dan menginisialisasi variabel:

```v
fn main() {
    name := 'V'
    version := 0.5
    is_awesome := true
    println('${name} v${version} is awesome: ${is_awesome}')
}
```

## Berikutnya

[Bab 2: Membangun Proyek](ch02-building-a-project.md)
