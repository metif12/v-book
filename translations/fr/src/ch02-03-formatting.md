# Formatage avec v fmt

V dispose d'un formateur de code intégré :

```bash
v fmt -w .
```

L'option `-w` écrit les modifications dans les fichiers. Sans elle, le formateur affiche le résultat sur la sortie standard.

## Exemple

Avant :

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
Après `v fmt` :

```v
fn shout(s string) string {
	return s.to_upper()
}

fn main() {
	println(shout('hello formats'))
}
```
## Suivant

[Tests avec v test](ch02-04-testing.md)
