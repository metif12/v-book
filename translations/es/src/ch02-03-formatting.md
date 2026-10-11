# Formateo con v fmt

V tiene un formateador de código integrado:

```bash
v fmt -w .
```

La opción `-w` escribe los cambios de vuelta en los archivos. Sin ella, el formateador imprime en la salida estándar.

## Ejemplo

Antes:

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
Después de `v fmt`:

```v
fn shout(s string) string {
	return s.to_upper()
}

fn main() {
	println(shout('hello formats'))
}
```
## Siguiente

[Pruebas con v test](ch02-04-testing.md)
