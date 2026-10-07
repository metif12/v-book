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

## String methods

```v
fn main() {
    s := '  hello  '
    println(s.trim_space())
    println(s.split(','))
    println(s.replace('l', 'L'))
}
```

## Next

[Chapter 9: Error Handling](ch09-error-handling.md)
