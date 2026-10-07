# Bab 4: Kepemilikan dan Memori

V mengambil pendekatan yang berbeda dalam manajemen memori dibanding banyak bahasa lain. Alih-alih manajemen memori manual atau garbage collection semata, V menawarkan beberapa strategi.

## Stack dan Heap

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

## Garbage Collection

V menggunakan garbage collector secara default. Anda tidak perlu membebaskan memori secara manual:

```v
fn main() {
    mut names := []string{}
    for i in 0 .. 100 {
        names << 'name ${i}'
    }
    // Memory is automatically freed when no longer referenced
    println(names.len)
}
```

## Autofree

V memiliki mode autofree yang secara otomatis membebaskan memori ketika variabel keluar dari scope:

```bash
v -autofree main.v
```

```v
fn process() {
    mut data := []int{}
    for i in 0 .. 1000 {
        data << i
    }
    // data is automatically freed here
}

fn main() {
    process()
    println('done')
}
```

## Referensi

Anda dapat menggunakan referensi untuk menghindari penyalinan data besar:

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

## Mode manajemen memori

| Mode | Flag | Deskripsi |
|------|------|-------------|
| GC (default) | `-gc boehm` | Boehm garbage collector |
| Autofree | `-autofree` | Automatic memory freeing |
| None | `-gc none` | Manual memory management |
| Prealloc | `-prealloc` | Arena allocation |

## Ringkasan

Dalam bab ini, Anda telah belajar tentang opsi manajemen memori V. Di bab berikutnya, kita akan menjelajahi struct.
