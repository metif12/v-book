# ガベージコレクション

Vはデフォルトでガベージコレクタを使用します：

```v
fn main() {
    mut names := []string{}
    for i in 0 .. 100 {
        names << 'name ${i}'
    }
    // Memory is automatically freed when no longer referenced
    println(names.len)
}
```
## GCの無効化

パフォーマンスが重要なコードでは、GCを無効にできます：

```bash
v -gc none main.v
```

## 次へ

[Autofree](ch04-03-autofree.md)
