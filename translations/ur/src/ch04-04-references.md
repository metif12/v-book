# حوالہ جات

بڑے ڈیٹا کی کاپی سے بچنے کے لیے حوالہ جات استعمال کریں:

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

## اگلا

[باب ۵: structs](ch05-structs.md)
