# Hello, World!

`main.v`というファイルを作成します：

```v
fn main() {
    println('Hello, World!')
}
```

実行します：

```bash
v run main.v
```

出力：

```
Hello, World!
```

## Vプログラムの構造

プログラムを分解してみましょう：

- `fn main()` — すべてのVプログラムは`main`関数から始まります。`fn`キーワードは関数を宣言します。
- `println(...)` — 標準出力に一行を出力する組み込み関数です。
- `'Hello, World!'` — 文字列リテラルです。Vでは文字列にシングルクォートを使用します。

## コンパイルと実行

`v run`はコンパイルと実行を一度に行います。最初にコンパイルすることもできます：

```bash
v main.v
./main
```

## 次へ

[Hello, V!](ch01-03-hello-v.md)
