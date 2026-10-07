# فصل ۴: مالکیت و حافظه

V رویکرد متفاوتی نسبت به مدیریت حافظه نسبت به بسیاری از زبان‌ها دارد. به جای مدیریت دستی حافظه یا فقط جمع‌آوری زباله، V چندین استراتژی ارائه می‌دهد.

## پشته و هیپ

V به صورت خودکار تصمیم می‌گیرد که آیا در پشته یا هیپ تخصیص دهد:

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

## جمع‌آوری زباله

V به صورت پیش‌فرض از یک جمع‌آوری زباله استفاده می‌کند. شما نیازی ندارید حافظه را به صورت دستی آزاد کنید:

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

## آزادسازی خودکار

V یک حالت آزادسازی خودکار دارد که به صورت خودکار حافظه را وقتی متغیرها از محدوده خارج می‌شوند آزاد می‌کند:

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

## مراجع

می‌توانید از مراجع برای جلوگیری از کپی کردن داده‌های بزرگ استفاده کنید:

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

## حالت‌های مدیریت حافظه

| حالت | پرچم | توضیح |
|------|------|-------------|
| GC (پیش‌فرض) | `-gc boehm` | جمع‌آوری زباله Boehm |
| آزادسازی خودکار | `-autofree` | آزادسازی خودکار حافظه |
| هیچ | `-gc none` | مدیریت دستی حافظه |
| پیش‌تخصیص | `-prealloc` | تخصیص آرنا |

## خلاصه

در این فصل، درباره گزینه‌های مدیریت حافظه V یاد گرفتید. در فصل بعد، به struct ها می‌پردازیم.
