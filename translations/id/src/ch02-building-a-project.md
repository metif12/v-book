# Bab 2: Membangun Proyek

Dalam bab ini, Anda akan belajar cara mengstruktur proyek V, menggunakan `v.mod`, memformat kode dengan `v fmt`, dan menulis test dengan `v test`.

## Struktur proyek

Sebuah proyek V adalah direktori dengan file `v.mod` dan satu atau lebih file `.v`:

```
my_project/
├── v.mod
├── main.v
└── my_module.v
```

## v.mod

Setiap proyek V memiliki file `v.mod` yang mendeskripsikan proyek:

```v ignore
Module {
    name: 'my_project'
    description: 'My first V project'
    version: '0.1.0'
    license: 'MIT'
    dependencies: []
}
```

Buat proyek baru dengan:

```bash
v init
```

Ini membuat `v.mod` dan `main.v` dengan template dasar.

## Memformat dengan v fmt

V memiliki formatter kode bawaan. Jalankan pada proyek Anda:

```bash
v fmt -w .
```

Flag `-w` menulis kode yang telah diformat kembali ke file.

## Menguji dengan v test

V memiliki framework testing bawaan. Buat file yang diakhiri dengan `_test.v`:

```v
fn add(a int, b int) int {
    return a + b
}

fn test_add() {
    assert add(2, 3) == 5
    assert add(-1, 1) == 0
}
```

Jalankan test:

```bash
v test .
```

## Ringkasan

Dalam bab ini, Anda telah belajar cara mengstruktur proyek V, menggunakan `v.mod`, memformat kode, dan menulis test. Di bab berikutnya, kita akan membahas konsep pemrograman umum dalam V.
