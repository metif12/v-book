# v fmt ile Biçimlendirme

V'nin yerleşik bir kod biçimlendiricisi vardır:

```bash
v fmt -w .
```

`-w` bayrağı değişiklikleri dosyaların üzerine yazar. Bu bayrak olmadan, biçimlendirici stdout'a yazdırır.

## Örnek

Öncesi:

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
`v fmt` sonrası:

```v
fn shout(s string) string {
	return s.to_upper()
}

fn main() {
	println(shout('hello formats'))
}
```
## Sonraki

[v test ile Test Etme](ch02-04-testing.md)
