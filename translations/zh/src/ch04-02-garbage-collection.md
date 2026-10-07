# 垃圾回收

V 默认使用垃圾回收器：

```v
fn main() {
    mut names := []string{}
    for i in 0 .. 100 {
        names << 'name ${i}'
    }
    // 内存不再被引用时自动释放
    println(names.len)
}
```

## 禁用 GC

对于性能关键型代码，你可以禁用 GC：

```bash
v -gc none main.v
```

## 下一步

[自动释放](ch04-03-autofree.md)
