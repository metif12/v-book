# 第1章：はじめに

Vの旅を始めましょう！学ぶことはたくさんありますが、すべての旅は一歩から始まります。この章では、以下の方法を学びます：

- システムにVをインストールする
- "Hello, World!"プログラムを書く
- Vコンパイラとそのコマンドを使う
- Vプロジェクトを作成する

## インストール

VはWindows、macOS、Linuxにインストールできます。最も簡単な方法はインストーラースクリプトを使うことです：

### Windows

[vlang.io/install](https://vlang.io/install.html)からインストーラーをダウンロードして実行するか、PowerShellを使用します：

```powershell
irm https://raw.githubusercontent.com/vlang/v/master/installer.ps1 | iex
```

### macOS

```bash
brew install vlang
```

またはインストーラースクリプトを使用します：

```bash
curl -sSL https://raw.githubusercontent.com/vlang/v/master/installer.sh | bash
```

### Linux

```bash
curl -sSL https://raw.githubusercontent.com/vlang/v/master/installer.sh | bash
```

### ソースからビルド

ソースからVをビルドするには：

```bash
git clone https://github.com/vlang/v
cd v
make
```

## インストールの確認

インストール後、Vが動作することを確認します：

```bash
v version
```

以下のような出力が表示されます：

```
V 0.5.2
```

## Hello, World!

それでは最初のVプログラムを書いてみましょう。`main.v`というファイルを作成します：

```v
fn main() {
    println('Hello, World!')
}
```

実行します：

```bash
v run main.v
```

以下のように表示されます：

```
Hello, World!
```

おめでとうございます！最初のVプログラムを書いて実行しました。

## Hello, V!

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

## Vコンパイラ

Vコンパイラは`v`コマンドで呼び出されます。一般的なコマンド：

| コマンド | 説明 |
|---------|-------------|
| `v run file.v` | Vファイルをコンパイルして実行 |
| `v file.v` | Vファイルを実行可能ファイルにコンパイル |
| `v fmt file.v` | Vファイルをフォーマット |
| `v test .` | 現在のディレクトリでテストを実行 |
| `v doc .` | ドキュメントを生成 |
| `v doctor` | Vのインストールを診断 |

## まとめ

この章では、Vのインストール方法、"Hello, World!"プログラムの書き方、Vコンパイラの使い方を学びました。次の章では、Vプロジェクトの構造を見ていきます。
