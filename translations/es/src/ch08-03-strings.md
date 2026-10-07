# Strings

```v
fn main() {
    s := 'Hello, World!'
    println(s.len)
    println(s[0])
    println(s.contains('World'))
    println(s.to_upper())
}
```

## Métodos de strings

```v
fn main() {
    s := '  hello  '
    println(s.trim_space())
    println(s.split(','))
    println(s.replace('l', 'L'))
}
```

## Siguiente

[Capítulo 9: Manejo de Errores](ch09-error-handling.md)
