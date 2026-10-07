# Строки

```v
fn main() {
    s := 'Hello, World!'
    println(s.len)
    println(s[0])
    println(s.contains('World'))
    println(s.to_upper())
}
```

## Методы строк

```v
fn main() {
    s := '  hello  '
    println(s.trim_space())
    println(s.split(','))
    println(s.replace('l', 'L'))
}
```

## Далее

[Глава 9: Обработка ошибок](ch09-error-handling.md)
