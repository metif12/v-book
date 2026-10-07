# سلام، V!

بیایید یک نمونه جالب‌تر را بررسی کنیم:

```v
fn main() {
    name := 'V'
    println('Hello, ${name}!')
    println('${name} is a great language.')
}
```

آن را اجرا کنید:

```bash
v run main.v
```

خروجی:

```
Hello, V!
V is a great language.
```

## درون‌یابی رشته

V از `${...}` برای درون‌یابی رشته استفاده می‌کند. هر عبارت داخل `${...}` ارزیابی و به رشته تبدیل می‌شود:

```v
fn main() {
    a := 42
    b := 3.14
    println('a = ${a}, b = ${b}')
    println('a + 10 = ${a + 10}')
}
```

## متغیرها

از `:=` برای تعریف و مقداردهی اولیه یک متغیر استفاده کنید:

```v
fn main() {
    name := 'V'
    version := 0.5
    is_awesome := true
    println('${name} v${version} is awesome: ${is_awesome}')
}
```

## بعدی

[فصل ۲: ساخت یک پروژه](ch02-building-a-project.md)
