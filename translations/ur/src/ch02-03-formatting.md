# v fmt کے ساتھ فارمیٹنگ

V میں ایک بلٹ اِن کوڈ فارمیٹر ہے:

```bash
v fmt -w .
```

`-w` فلگ تبدیلیوں کو فائلوں میں واپس لکھتا ہے۔ اس کے بغیر، فارمیٹر stdout پر پرنٹ کرتا ہے۔

## مثال

پہلے:

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
`v fmt` کے بعد:

```v
fn shout(s string) string {
	return s.to_upper()
}

fn main() {
	println(shout('hello formats'))
}
```
## اگلا

[v test کے ساتھ ٹیسٹنگ](ch02-04-testing.md)
