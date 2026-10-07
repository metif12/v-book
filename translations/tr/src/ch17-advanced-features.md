# Bölüm 17: Gelişmiş Özellikler

## Nitelikler (Attributes)

Nitelikler, bildirimlerin önüne yerleştirilen meta veri açıklamalarıdır. Derleyici davranışını, optimizasyon ipuçlarını ve API yaşam döngüsünü kontrol eder.

### [deprecated]

Bir fonksiyonu veya tipi kullanımdan kaldırılmış olarak işaretler. Derleyici, öğe kullanıldığında bir uyarı yayar.

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

Derleyicinin fonksiyonu çağırma noktasında satır içi yapmasına ipucu verir, çağrı maliyetini ortadan kaldırır. Küçük, sık çağrılan fonksiyonlar için en iyisidir.

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

Bir fonksiyonu güvensiz olarak işaretler, çağıranın da güvensiz işaretlenmesine gerek kalmadan `unsafe` bloklarını kullanmasına izin verir.

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

Derleme zamanında koşullu derleme. Blok yalnızca koşul doğru olduğunda dahil edilir.

```v
$if debug {
    println('Debug mode enabled')
} $else {
    println('Release mode')
}
```

## Derleme zamanı kod

V, derleme sırasında yürütülen ve metaprogramlama ve sıfır maliyetli soyutlamalar sağlayan çeşitli derleme zamanı yapıları sağlar.

### $if

Koşulları derleme zamanında değerlendirir. Platform algılama, mimari kontroller ve özel bayrakları destekler.

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

Derleme zamanında diziler, struct alanları veya arayüzler üzerinde yineleme yapar. Tekrarlayan kod oluşturmak için kullanışlıdır.

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

Koşul yanlışsa derlemeyi durduran derleme zamanı assert ifadeleri.

```v
$assert sizeof(int) == 8 || sizeof(int) == 4
$assert @VMOD_FILE.len > 0

fn main() {
    println('Assertions passed')
}
```

## Operatör aşırı yükleme

V, kullanıcı tanımlı tipler için operatörlerin özel davranışlarını tanımlamaya izin verir. Her operatör, belirli bir imzaya sahip bir metoda eşlenir.

### Aritmetik operatörler

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

### Karşılaştırma operatörleri

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

### İndeks operatörü

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

## Derleme zamanı yansıma

V'nin `$for` yapısı, derleme zamanında struct alanları üzerinde yineleme yapabilir, otomatik serileştirme, doğrulama ve daha fazlasını mümkün kılar.

### Struct alanları üzerinde yineleme

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

### Doğrulama kodu oluşturma

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

## Özet

Bu bölümde nitelikler, derleme zamanı kod, operatör aşırı yükleme ve derleme zamanı yansıma hakkında bilgi edindiniz. Bu özellikler güçlü metaprogramlama desenlerini ve derleme üzerinde ince kontrolü mümkün kılar. Sonraki bölümde bellek yönetimini derinlemesine inceleyeceğiz.
