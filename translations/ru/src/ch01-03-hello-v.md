# Привет, V!

Давайте рассмотрим более интересный пример:

```v
fn main() {
    name := 'V'
    println('Hello, ${name}!')
    println('${name} is a great language.')
}
```

Запустите его:

```bash
v run main.v
```

Вывод:

```
Hello, V!
V is a great language.
```

## Интерполяция строк

В V для интерполяции строк используется `${...}`. Любое выражение внутри `${...}` вычисляется и преобразуется в строку:

```v
fn main() {
    a := 42
    b := 3.14
    println('a = ${a}, b = ${b}')
    println('a + 10 = ${a + 10}')
}
```

## Переменные

Используйте `:=` для объявления и инициализации переменной:

```v
fn main() {
    name := 'V'
    version := 0.5
    is_awesome := true
    println('${name} v${version} is awesome: ${is_awesome}')
}
```

## Далее

[Глава 2: Создание проекта](ch02-building-a-project.md)
