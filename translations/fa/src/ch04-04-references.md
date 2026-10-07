# مراجع

از مراجع برای جلوگیری از کپی کردن داده‌های بزرگ استفاده کنید:

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

## بعدی

[فصل ۵: struct ها](ch05-structs.md)
