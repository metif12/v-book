# 第4章：所有権とメモリ

Vは、多くの言語とは異なるメモリ管理アプローチを採用しています。手動メモリ管理やガベージコレクションだけではなく、複数の戦略を提供しています。

## スタックとヒープ

Vはスタックとヒープのどちらに割り当てるかを自動的に決定します：

```v
fn main() {
    // Stack-allocated (small, fixed size)
    x := 42
    arr := [1, 2, 3]

    // Heap-allocated (large, dynamic)
    mut big := []int{}
    for i in 0 .. 1000 {
        big << i
    }

    println('${x} ${arr} ${big.len}')
}
```
## ガベージコレクション

Vはデフォルトでガベージコレクタを使用します。メモリを手動で解放する必要はありません：

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
## Autofree

Vには変数のスコープが終了したときにメモリを自動的に解放するautofreeモードがあります：

```bash
v -autofree main.v
```

```v
fn process() {
    mut data := []int{}
    for i in 0 .. 1000 {
        data << i
    }
    // data is automatically freed here
}

fn main() {
    process()
    println('done')
}
```
## 参照

大きなデータのコピーを避けるために参照を使用できます：

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
## メモリ管理モード

| モード | フラグ | 説明 |
|------|------|-------------|
| GC（デフォルト） | `-gc boehm` | Boehmガベージコレクタ |
| Autofree | `-autofree` | 自動メモリ解放 |
| なし | `-gc none` | 手動メモリ管理 |
| Prealloc | `-prealloc` | アリーナ割り当て |

## まとめ

この章では、Vのメモリ管理オプションについて学びました。次の章では、structを見ていきます。
