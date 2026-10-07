# المتغيرات والتغيير

في V، المتغيرات غير قابلة للتغيير افتراضياً:

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

## التعريف

استخدم `:=` للتعريف والتهيئة:

```v
x := 42
name := 'V'
is_ready := true
```

## استنتاج النوع

V يستنتج الأنواع من المُهيّئ:

```v
a := 42      // int
b := 3.14    // f64
c := 'hello' // string
d := true    // bool
```

## الأنواع الصريحة

يمكنك تحديد الأنواع صراحةً:

```v
a := i64(42)
b := f32(3.14)
c := u8(255)
```

## التالي

[أنواع البيانات](ch03-02-data-types.md)
