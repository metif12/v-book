# Formattazione con v fmt

V ha un formattatore di codice integrato:

```bash
v fmt -w .
```

Il flag `-w` scrive le modifiche nei file. Senza di esso, il formattatore stampa su stdout.

## Esempio

Prima:

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
Dopo `v fmt`:

```v
fn shout(s string) string {
	return s.to_upper()
}

fn main() {
	println(shout('hello formats'))
}
```
## Avanti

[Testing con v test](ch02-04-testing.md)
