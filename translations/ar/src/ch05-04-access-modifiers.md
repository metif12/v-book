# محددات الوصول

الحقول خاصة افتراضياً:

```v
struct User {
    name string
pub:
    age int
}

fn main() {
    u := User{name: 'Alice', age: 30}
    println(u.name)  // OK: same module
    println(u.age)   // OK: public
}
```

## الظهور

| المحدد | النطاق |
|----------|-------|
| (بدون) | الوحدة فقط |
| `pub` | عام |

## التالي

[الفصل 6: Enums وأنواع الجمع](ch06-enums-and-sum-types.md)
