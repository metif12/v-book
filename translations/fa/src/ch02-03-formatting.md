# قالب‌بندی با v fmt

V یک قالب‌بند کد داخلی دارد:

```bash
v fmt -w .
```

پرچم `-w` تغییرات را به فایل‌ها بازنویسی می‌کند. بدون آن، قالب‌بند خروجی را به stdout چاپ می‌کند.

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
بعد از `v fmt`:

```v
fn shout(s string) string {
	return s.to_upper()
}

fn main() {
	println(shout('hello formats'))
}
```
## بعدی

[تست با v test](ch02-04-testing.md)
