# Formatação com v fmt

V tem um formatador de código imbutido:

```bash
v fmt -w .
```

A flag `-w` escreve as alterações de volta nos arquivos. Sem ela, o formatador imprime na saída padrão.

## Exemplo

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
Depois de `v fmt`:

```v
fn shout(s string) string {
	return s.to_upper()
}

fn main() {
	println(shout('hello formats'))
}
```
## Próximo

[Testes com v test](ch02-04-testing.md)
