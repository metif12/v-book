# Форматирование с помощью v fmt

В V есть встроенный форматтер кода:

```bash
v fmt -w .
```

Флаг `-w` записывает изменения обратно в файлы. Без него форматтер выводит результат в стандартный поток вывода.

## Пример

До:

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
После `v fmt`:

```v
fn shout(s string) string {
	return s.to_upper()
}

fn main() {
	println(shout('hello formats'))
}
```
## Далее

[Тестирование с помощью v test](ch02-04-testing.md)
