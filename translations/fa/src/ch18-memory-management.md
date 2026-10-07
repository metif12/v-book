# فصل ۱۸: بررسی عمیق مدیریت حافظه

## حالت‌های GC

V چندین استراتژی مدیریت حافظه ارائه می‌دهد، هر کدام برای موارد استفاده مختلف مناسب هستند.

| حالت | پرچم | مورد استفاده |
|------|------|----------|
| Boehm GC | `-gc boehm` | منظور عمومی |
| آزادسازی خودکار | `-autofree` | آزادسازی خودکار |
| هیچ | `-gc none` | مدیریت دستی |
| پیش‌تخصیص | `-prealloc` | تخصیص آرنا |

## پشته در مقابل هیپ

V به صورت خودکار تصمیم می‌گیرد که حافظه را کجا تخصیص دهد. مقادیر کوچک و کوتاه‌مدت در پشته باقی می‌مانند. مقادیر بزرگتر یا فرار شده به هیپ می‌روند.

```v
fn stack_example() int {
    x := 42
    y := x * 2
    return y
}

fn heap_example() []int {
    data := []int{len: 100, init: 0}
    return data
}

fn main() {
    a := stack_example()
    b := heap_example()
    println(a)
    println(b.len)
}
```

## حالت آزادسازی خودکار

آزادسازی خودکار به صورت خودکار حافظه را وقتی متغیرها از محدوده خارج می‌شوند آزاد می‌کند. از شمارش مراجع برای تخصیص‌های هیپ استفاده می‌کند.

```v
fn create_user(name string) string {
    greeting := 'Hello, ${name}!'
    return greeting
}

fn main() {
    msg := create_user('World')
    println(msg)
}
```

## -gc none و حافظه دستی

با `-gc none`، V جمع‌آوری زباله را غیرفعال می‌کند. باید حافظه را با `free` به صورت دستی مدیریت کنید.

```v
fn main() {
    mut data := []int{len: 1000, init: 0}
    for i in 0 .. 1000 {
        data[i] = i * 2
    }
    println(data[500])
    unsafe {
        data.free()
    }
}
```

## تخصیص آرنا -prealloc

Prealloc از تخصیص آرنا برای عملکرد بهتر در حلقه‌های فشرده استفاده می‌کند. تخصیص‌ها به صورت انبوه آزاد می‌شوند.

```v
fn process_items(count int) int {
    mut total := 0
    $if prealloc {
        for i in 0 .. count {
            total += i * i
        }
    } $else {
        for i in 0 .. count {
            total += i * i
        }
    }
    return total
}

fn main() {
    result := process_items(10000)
    println(result)
}
```

## کد ناامن

بلوک `unsafe` عملیاتی را که تضمین‌های ایمنی V را دور می‌زنند اجازه می‌دهد، مانند حساب اشاره‌گر و دسترسی مستقیم به حافظه.

```v
fn main() {
    x := 42
    p := unsafe { &x }
    println(p)
    unsafe {
        q := p + 1
        println(q)
    }
}
```

### حساب اشاره‌گر

```v
fn main() {
    arr := [10, 20, 30, 40, 50]
    unsafe {
        p := &arr[0]
        first := p[0]
        second := p[1]
        third := p[2]
        println('${first} ${second} ${third}')
    }
}
```

## تنظیم عملکرد

انتخاب حالت مدیریت حافظه مناسب می‌تواند به طور قابل توجهی بر عملکرد تأثیر بگذارد.

### بنچ‌مارک حالت‌های مختلف

```v
fn benchmark_allocations(iterations int) i64 {
    sw := i64(0)
    $if boehm ? {
        sw = i64(1)
    }
    $if autofree ? {
        sw = i64(2)
    }
    $if prealloc ? {
        sw = i64(3)
    }
    return sw
}

fn main() {
    mode := benchmark_allocations(1000000)
    println('Mode: ${mode}')
}
```

### بهینه‌سازی ساختارهای داده

```v
struct Point {
    x f64
    y f64
}

fn sum_points(points []Point) f64 {
    mut total := 0.0
    for p in points {
        total += p.x + p.y
    }
    return total
}

fn main() {
    points := []Point{len: 10000, init: Point{x: 1.0, y: 2.0}}
    result := sum_points(points)
    println(result)
}
```

## خلاصه

در این فصل، درباره حالت‌های مدیریت حافظه، تخصیص پشته در مقابل هیپ، آزادسازی خودکار، مدیریت دستی حافظه، prealloc، کد ناامن و تنظیم عملکرد یاد گرفتید. در فصل بعد، به ابزارها می‌پردازیم.
