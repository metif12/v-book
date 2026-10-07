# v fmtによるフォーマット

Vには組み込みのコードフォーマッターがあります：

```bash
v fmt -w .
```

`-w`フラグは変更をファイルに書き戻します。指定しない場合、フォーマッターは標準出力に表示します。

## 例

フォーマット前：

```v
fn main(){
println( 'hello' )
}
```

`v fmt`実行後：

```v
fn main() {
    println('hello')
}
```

## 次へ

[v testによるテスト](ch02-04-testing.md)
