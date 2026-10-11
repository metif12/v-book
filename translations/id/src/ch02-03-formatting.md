# Memformat dengan v fmt

V memiliki formatter kode bawaan:

```bash
v fmt -w .
```

Flag `-w` menulis perubahan kembali ke file. Tanpa flag tersebut, formatter mencetak ke stdout.

## Contoh

Sebelum:

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
Setelah `v fmt`:

```v
fn shout(s string) string {
	return s.to_upper()
}

fn main() {
	println(shout('hello formats'))
}
```
## Berikutnya

[Menguji dengan v test](ch02-04-testing.md)
