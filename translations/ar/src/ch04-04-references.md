# المراجع

استخدم المراجع لتجنب نسخ البيانات الكبيرة:

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

## التالي

[الفصل 5: Structs](ch05-structs.md)
