# Hello, V!

もう少し興味深い例を見てみましょう：

```v
fn main() {
    name := 'V'
    println('Hello, ${name}!')
    println('${name} is a great language.')
}
```

実行します：

```bash
v run main.v
```

出力：

```
Hello, V!
V is a great language.
```

## 文字列補間

Vでは`${...}`を文字列補間に使用します。`${...}`内の任意の式が評価されて文字列に変換されます：

```v
fn main() {
    a := 42
    b := 3.14
    println('a = ${a}, b = ${b}')
    println('a + 10 = ${a + 10}')
}
```

## 変数

`:=`を使って変数を宣言して初期化します：

```v
fn main() {
    name := 'V'
    version := 0.5
    is_awesome := true
    println('${name} v${version} is awesome: ${is_awesome}')
}
```

## 次へ

[第2章：プロジェクトの構築](ch02-building-a-project.md)
