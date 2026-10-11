# v fmtによるフォーマット

Vには組み込みのコードフォーマッターがあります：

```bash
v fmt -w .
```

`-w`フラグは変更をファイルに書き戻します。指定しない場合、フォーマッターは標準出力に表示します。

## 例

フォーマット前：

```v
struct Config {
mut:
	debug bool
	path  string
}

fn describe(c Config) string {
	return 'debug=${c.debug} path=${c.path}'
}

fn main() {
	c := Config{
		debug: true
		path:  '/tmp/app'
	}
	println(describe(c))
	assert describe(c) == 'debug=true path=/tmp/app'
}
```
`v fmt`実行後：

```v
fn shout(s string) string {
	return s.to_upper()
}

fn main() {
	println(shout('hello formats'))
}
```
## 次へ

[v testによるテスト](ch02-04-testing.md)
