# v fmt로 포맷팅하기

V에는 내장 코드 포매터가 있습니다:

```bash
v fmt -w .
```

`-w` 플래그는 변경 사항을 파일에 다시 저장합니다. 없으면 포매터가 stdout에 출력합니다.

## 예제

포맷팅 전:

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
`v fmt` 후:

```v
fn shout(s string) string {
	return s.to_upper()
}

fn main() {
	println(shout('hello formats'))
}
```
## 다음

[v test로 테스트하기](ch02-04-testing.md)
