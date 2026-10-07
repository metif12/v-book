# ہیلو، V!

آئیے ایک مزید دلچسپ مثال دیکھتے ہیں:

```v
fn main() {
    name := 'V'
    println('Hello, ${name}!')
    println('${name} is a great language.')
}
```

اسے چلائیں:

```bash
v run main.v
```

آؤٹ پٹ:

```
Hello, V!
V is a great language.
```

## اسٹرنگ انٹرپولیشن

V اسٹرنگ انٹرپولیشن کے لیے `${...}` استعمال کرتا ہے۔ `${...}` کے اندر کوئی بھی ایکسپریشن جایز ہے اور اسے اسٹرنگ میں تبدیل کیا جاتا ہے:

```v
fn main() {
    a := 42
    b := 3.14
    println('a = ${a}, b = ${b}')
    println('a + 10 = ${a + 10}')
}
```

## متغیرات

متغیر کی تعریف اور ابتدائی قدر کے لیے `:=` استعمال کریں:

```v
fn main() {
    name := 'V'
    version := 0.5
    is_awesome := true
    println('${name} v${version} is awesome: ${is_awesome}')
}
```

## اگلا

[باب ۲: پروجیکٹ بنانا](ch02-building-a-project.md)
