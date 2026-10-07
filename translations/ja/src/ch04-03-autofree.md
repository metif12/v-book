# Autofree

Vにはメモリを自動的に解放するautofreeモードがあります：

```bash
v -autofree main.v
```

```v
fn process() {
    mut data := []int{}
    for i in 0 .. 1000 {
        data << i
    }
    // dataはここで自動的に解放されます
}

fn main() {
    process()
    println('done')
}
```

## 次へ

[参照](ch04-04-references.md)
