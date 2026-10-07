# متغیرات اور تبدیلی پذیری

V میں، متغیرات ڈیفالٹ طور پر غیر تبدیل پذیر ہوتے ہیں:

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

تعریف اور ابتدائی قدر کے لیے `:=` استعمال کریں:

```v
x := 42
name := 'V'
is_ready := true
```

## ٹائپ کا استنتاج

V ابتدائی قدر سے ٹائپ کا استنتاج کرتا ہے:

```v
a := 42      // int
b := 3.14    // f64
c := 'hello' // string
d := true    // bool
```

## صریح اقسام

آپ اقسام کو صریح طور پر بھی بتا سکتے ہیں:

```v
a := i64(42)
b := f32(3.14)
c := u8(255)
```

## اگلا

[ڈیٹا کی اقسام](ch03-02-data-types.md)
