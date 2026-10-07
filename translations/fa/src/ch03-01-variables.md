# متغیرها و تغییرپذیری

در V، متغیرها به صورت پیش‌فرض غیرقابل تغییر هستند:

```v
fn main() {
    name := 'V'
    // name = 'Go'  // Error: name is immutable

    mut count := 0
    count = 1  // OK: count is mutable
    count++
    println(count)
}
```

## تعریف

از `:=` برای تعریف و مقداردهی اولیه استفاده کنید:

```v
x := 42
name := 'V'
is_ready := true
```

## استنتاج نوع

V انواع را از مقداردهی اولیه استنتاج می‌کند:

```v
a := 42      // int
b := 3.14    // f64
c := 'hello' // string
d := true    // bool
```

## انواع صریح

می‌توانید انواع را به صراحت مشخص کنید:

```v
a := i64(42)
b := f32(3.14)
c := u8(255)
```

## بعدی

[انواع داده](ch03-02-data-types.md)
