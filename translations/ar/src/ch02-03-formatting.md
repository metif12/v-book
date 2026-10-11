# التنسيق مع v fmt

V يحتوي على مُنسّق كود مدمج:

```bash
v fmt -w .
```

العلمة `-w` تكتب التغييرات مرة أخرى إلى الملفات. بدونها، يطبع المُنسّق إلى stdout.

## مثال

قبل:

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
بعد `v fmt`:

```v
fn shout(s string) string {
	return s.to_upper()
}

fn main() {
	println(shout('hello formats'))
}
```
## التالي

[الاختبار مع v test](ch02-04-testing.md)
