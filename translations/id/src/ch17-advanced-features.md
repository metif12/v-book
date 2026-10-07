# Bab 17: Fitur Lanjutan

## Atribut

Atribut adalah anotasi metadata yang ditempatkan sebelum deklarasi. Mereka mengontrol perilaku kompiler, petunjuk optimasi, dan siklus hidup API.

### [deprecated]

Menandai fungsi atau tipe sebagai deprecated. Kompiler mengeluarkan peringatan ketika item digunakan.

```v
[deprecated]
fn old_add(a int, b int) int {
    return a + b
}

[deprecated: 'Use new_add instead']
fn old_multiply(a int, b int) int {
    return a * b
}
```

### [inline]

Memberi petunjuk ke kompiler untuk inline fungsi di call site, menghilangkan overhead call. Terbaik untuk fungsi kecil yang sering dipanggil.

```v
[inline]
fn square(x int) int {
    return x * x
}

fn main() {
    result := square(5)
    println(result)
}
```

### [unsafe]

Menandai fungsi sebagai unsafe, memungkinkan penggunaan blok `unsafe` tanpa pemanggil juga ditandai unsafe.

```v
[unsafe]
fn read_pointer(ptr voidptr) int {
    return unsafe { *(&int(ptr)) }
}

fn main() {
    x := 42
    val := read_pointer(&x)
    println(val)
}
```

### [if]

Kompilasi kondisional saat compile time. Blok hanya disertakan ketika kondisi bernilai true.

```v
$if debug {
    println('Debug mode enabled')
} $else {
    println('Release mode')
}
```

## Kode compile-time

V menyediakan beberapa konstruk compile-time yang dieksekusi selama kompilasi, memungkinkan metaprogramming dan abstraksi zero-cost.

### $if

Mengevaluasi kondisi saat compile time. Mendukung deteksi platform, pemeriksaan arsitektur, dan flag kustom.

```v
$if windows {
    const os_name = 'Windows'
} $else $if macos {
    const os_name = 'macOS'
} $else $if linux {
    const os_name = 'Linux'
} $else {
    const os_name = 'Unknown'
}

fn main() {
    println('Running on ${os_name}')
}
```

### $for

Iterasi saat compile time pada array, field struct, atau range. Berguna untuk menghasilkan kode repetitif.

```v
const platforms = ['windows', 'linux', 'macos']

fn is_platform(name string) bool {
    return name in platforms
}

fn main() {
    println(is_platform('windows'))
    println(is_platform('linux'))
    println(is_platform('macos'))
    println(is_platform('freebsd'))
}
```

### $assert

Assertion compile-time yang menghentikan kompilasi jika kondisi bernilai false.

```v
$assert sizeof(int) == 8 || sizeof(int) == 4
$assert @VMOD_FILE.len > 0

fn main() {
    println('Assertions passed')
}
```

## Operator overloading

V memungkinkan definisi perilaku kustom untuk operator pada tipe yang didefinisikan pengguna. Setiap operator dipetakan ke metode dengan signature spesifik.

### Operator aritmatika

```v
struct Vec2 {
    x f64
    y f64
}

fn (a Vec2) + (b Vec2) Vec2 {
    return Vec2{x: a.x + b.x, y: a.y + b.y}
}

fn (a Vec2) - (b Vec2) Vec2 {
    return Vec2{x: a.x - b.x, y: a.y - b.y}
}

fn (a Vec2) * (b Vec2) Vec2 {
    return Vec2{x: a.x * b.x, y: a.y * b.y}
}

fn (a Vec2) / (b Vec2) Vec2 {
    return Vec2{x: a.x / b.x, y: a.y / b.y}
}

fn main() {
    a := Vec2{x: 10, y: 20}
    b := Vec2{x: 2, y: 4}
    sum := a + b
    diff := a - b
    prod := a * b
    quot := a / b
    println('Sum: ${sum.x}, ${sum.y}')
    println('Diff: ${diff.x}, ${diff.y}')
    println('Prod: ${prod.x}, ${prod.y}')
    println('Quot: ${quot.x}, ${quot.y}')
}
```

### Operator perbandingan

```v
struct Money {
    amount   f64
    currency string
}

fn (a Money) == (b Money) bool {
    return a.amount == b.amount && a.currency == b.currency
}

fn main() {
    a := Money{amount: 10.0, currency: 'USD'}
    b := Money{amount: 10.0, currency: 'USD'}
    c := Money{amount: 20.0, currency: 'USD'}
    println(a == b)
    println(a == c)
}
```

### Operator index

```v
struct Grid {
    data [][]int
}

fn (g Grid) row_count() int {
    return g.data.len
}

fn (g Grid) get(row int, col int) int {
    return g.data[row][col]
}

fn main() {
    g := Grid{
        data: [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
    }
    println(g.row_count())
    println(g.get(1, 2))
}
```

## Refleksi compile-time

Konstruk `$for` V dapat mengiterasi field struct saat compile time, memungkinkan serialisasi otomatis, validasi, dan lainnya.

### Iterasi field struct

```v
struct User {
    id    int
    name  string
    email string
    age   int
}

fn main() {
    u := User{
        id: 1
        name: 'Alice'
        email: 'alice@example.com'
        age: 30
    }
    $for field in User.fields {
        $if field.typ is string {
            println('${field.name} is a string field')
        } $else $if field.typ is int {
            println('${field.name} is an int field')
        }
    }
    println('${u.name} is ${u.age} years old')
}
```

### Menghasilkan kode validasi

```v
struct Config {
    host    string
    port    int
    timeout f64
}

fn validate_config(c Config) ! {
    $for field in Config.fields {
        $if field.typ is string {
            if c.$(field.name).len == 0 {
                return error('${field.name} must not be empty')
            }
        } $else $if field.typ is int {
            if c.$(field.name) <= 0 {
                return error('${field.name} must be positive')
            }
        }
    }
}

fn main() {
    cfg := Config{
        host: 'localhost'
        port: 8080
        timeout: 30.0
    }
    validate_config(cfg) or {
        println('Config invalid: ${err}')
        return
    }
    println('Config is valid')
}
```

## Ringkasan

Dalam bab ini, Anda telah belajar tentang atribut, kode compile-time, operator overloading, dan refleksi compile-time. Fitur-fitur ini memungkinkan pola metaprogramming yang kuat dan kontrol terperinci atas kompilasi. Di bab berikutnya, kita akan menjelajahi manajemen memori secara mendalam.
