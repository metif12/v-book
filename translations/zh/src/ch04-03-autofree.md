# 自动释放

V 有自动释放模式，自动释放内存：

```bash
v -autofree main.v
```

```v
fn process() {
    mut data := []int{}
    for i in 0 .. 1000 {
        data << i
    }
    // data 在这里自动释放
}

fn main() {
    process()
    println('done')
}
```

## 下一步

[引用](ch04-04-references.md)
