# Bab 7: Modul dan Paket

## Sistem Modul

V mengorganisir kode ke dalam modul. Sebuah modul adalah direktori dengan file `.v`:

```
my_project/
├── v.mod
├── main.v
└── math/
    └── math.v
```

`math/math.v`:

```v ignore
module math

pub fn add(a int, b int) int {
    return a + b
}
```

`main.v`:

```v ignore
import math

fn main() {
    println(math.add(2, 3))
}
```

## Visibilitas

- `pub` — public, dapat diakses dari modul lain
- (tanpa modifier) — private, hanya modul tersebut

## VPM

V Package Manager (VPM) menampung paket komunitas:

```bash
v install vsl
```

## Ringkasan

Dalam bab ini, Anda telah belajar tentang modul, visibilitas, dan VPM. Di bab berikutnya, kita akan menjelajahi koleksi.
