# Funktionen

Funktionen werden mit `fn` deklariert:

```v
fn add(a int, b int) int {
    return a + b
}

fn main() {
    result := add(2, 3)
    println(result)
}
```

## Mehrere Rückgabewerte

```v
fn divmod(a int, b int) (int, int) {
    return a / b, a % b
}

fn main() {
    q, r := divmod(17, 5)
    println('quotient: ${q}, remainder: ${r}')
}
```

## Kein Rückgabewert

```v
fn greet(name string) {
    println('Hello, ${name}!')
}

fn main() {
    greet('World')
}
```

## Function Hoisting

Funktionen können aufgerufen werden, bevor sie deklariert sind:

```v
fn main() {
    println(add(2, 3))
}

fn add(a int, b int) int {
    return a + b
}
```

## Weiter

[Kommentare](ch03-04-comments.md)
