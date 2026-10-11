# Formatierung mit v fmt

V verfügt über einen integrierten Code-Formatierer:

```bash
v fmt -w .
```

Das Flag `-w` schreibt Änderungen zurück in die Dateien. Ohne das Flag gibt der Formatierer auf der Standardausgabe aus.

## Beispiel

Vorher:

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
Nach `v fmt`:

```v
fn shout(s string) string {
	return s.to_upper()
}

fn main() {
	println(shout('hello formats'))
}
```
## Weiter

[Testen mit v test](ch02-04-testing.md)
