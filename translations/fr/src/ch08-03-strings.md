# Chaînes de caractères

```v
fn main() {
    s := 'Hello, World!'
    println(s.len)
    println(s[0])
    println(s.contains('World'))
    println(s.to_upper())
}
```

## Méthodes de chaîne

```v
fn main() {
    s := '  hello  '
    println(s.trim_space())
    println(s.split(','))
    println(s.replace('l', 'L'))
}
```

## Suivant

[Chapitre 9 : Gestion des erreurs](ch09-error-handling.md)
