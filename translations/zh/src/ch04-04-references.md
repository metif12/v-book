# 引用

使用引用来避免复制大量数据：

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

## 下一步

[第 5 章：结构体](ch05-structs.md)
