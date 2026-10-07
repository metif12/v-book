# باب ۱۷: جدید خصوصیات

## خصوصیات

خصوصیات تعریفات سے پہلے رکھے گئے میٹا ڈیٹا تشریف ہیں۔ یہ کمپائلر کے سلوک، بہتری کی اشارے، اور API کی زندگی کے دور کو کنٹرول کرتے ہیں۔

### [deprecated]

فنکشن یا ٹائپ کو فرسودہ کے طور پر نشان زد کرتا ہے۔ کمپائلر شے کے استعمال پر وارننگ خارج کرتا ہے۔

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

کمپائلر کو فنکشن کو کال سائٹ پر ان لائن کرنے کا اشارہ دیتا ہے، کال اوور ہیڈ کو ختم کرتا ہے۔ چھوٹے، زیادہ استعمال ہونے والے فنکشنز کے لیے بہترین۔

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

فنکشن کو غیر محفوظ کے طور پر نشان زد کرتا ہے، اسے `unsafe` بلاکس کو استعمال کرنے کی اجازت دیتا ہے بغیر کال کرنے والے کو بھی غیر محفوظ کے طور پر نشان زد کیے۔

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

کمپائل ٹائم پر مشروط کمپائلیشن۔ بلاک صرف اسی وقت شامل ہوتا ہے جب شرط سچ ہو۔

```v
$if debug {
    println('Debug mode enabled')
} $else {
    println('Release mode')
}
```

## کمپائل ٹائم کوڈ

V کمپائل ٹائم پر چلنے والے متعدد تصورات فراہم کرتا ہے جو کمپائلیشن کے دوران عمل کرتے ہیں، میٹا پروگرامنگ اور صفر لاگت کے تجربات کو فعال بناتے ہیں۔

### $if

کمپائل ٹائم پر شرائط کا جائزہ لیتا ہے۔ پلیٹ فارم کی شناخت، آرکٹیکچر کی جانچ، اور حسب منشا فلگز کی حمایت کرتا ہے۔

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

کمپائل ٹائم پر ارےز، struct فیلڈز، یا رینجز پر کرتا ہے۔ دہراتے کوڈ کی تیاری کے لیے مفید۔

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

کمپائل ٹائم پر اثبات جو شرط غلط ہونے پر کمپائلیشن کو روک دیتے ہیں۔

```v
$assert sizeof(int) == 8 || sizeof(int) == 4
$assert @VMOD_FILE.len > 0

fn main() {
    println('Assertions passed')
}
```

## آپریٹر اوور لوڈنگ

V صارف کی تعریف کردہ ٹائپس پر آپریٹرز کے لیے حسب منشا سلوک کی تعریف کی اجازت دیتا ہے۔ ہر آپریٹر ایک مخصوص دستخط کے ساتھ ایک میتھڈ سے منسلک ہوتا ہے۔

### حسابی آپریٹرز

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

### موازنہ آپریٹرز

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

### اشارہ آپریٹر

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

## کمپائل ٹائم عکاسی

V کا `$for` تصور کمپائل ٹائم پر struct فیلڈز پر کر سکتا ہے، خودکار سیریلائزیشن، تصدیق، اور مزید کو فعال بناتا ہے۔

### struct فیلڈز پر کرنا

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

### تصدیقی کوڈ کی تیاری

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

## خلاصہ

اس باب میں، آپ نے خصوصیات، کمپائل ٹائم کوڈ، آپریٹر اوور لوڈنگ، اور کمپائل ٹائم عکاسی کے بارے میں سیکھا۔ یہ خصوصیات طاقتور میٹا پروگرامنگ کے نمونوں اور کمپائلیشن پر باریک بینی کنٹرول کو فعال بناتی ہیں۔ اگلے باب میں، ہم میموری مینجمنٹ کو گہرائی سے دریافت کریں گے۔
