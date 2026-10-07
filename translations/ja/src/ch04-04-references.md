# 参照

大きなデータのコピーを避けるために参照を使用します：

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

## 次へ

[第5章：struct](ch05-structs.md)
