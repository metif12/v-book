# 第12章：I/Oプロジェクト：CLIツールの構築

この章では、ファイルを読み取って行数、単語数、文字数を数えるシンプルなコマンドラインツールを構築します。

## プロジェクトのセットアップ

```bash
mkdir wordcount
cd wordcount
v init
```

## 実装

```v no_run
import os

fn count(text string) (int, int, int) {
    lines := text.split('\n').len
    words := text.split(' ').len
    chars := text.len
    return lines, words, chars
}

fn main() {
    if os.args.len < 2 {
        println('Usage: wordcount <file>')
        exit(1)
    }

    path := os.args[1]
    content := os.read_file(path) or {
        println('Failed to read file: ${path}')
        exit(1)
    }

    lines, words, chars := count(content)
    println('Lines: ${lines}')
    println('Words: ${words}')
    println('Chars: ${chars}')
}
```

## 実行

```bash
v run . main.v
```

## まとめ

この章では、コマンドラインツールを構築しました。次の章では、関数型機能を見ていきます。
