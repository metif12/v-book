# Funzioni

Le funzioni sono dichiarate con `fn`:

```v
fn add(a int, b int) int {
    return a + b
}

fn main() {
    result := add(2, 3)
    println(result)
}
```

## Valori di ritorno multipli

```v
fn divmod(a int, b int) (int, int) {
    return a / b, a % b
}

fn main() {
    q, r := divmod(17, 5)
    println('quotient: ${q}, remainder: ${r}')
}
```

## Nessun valore di ritorno

```v
fn greet(name string) {
    println('Hello, ${name}!')
}

fn main() {
    greet('World')
}
```

## Hoisting delle funzioni

Le funzioni possono essere chiamate prima di essere dichiarate:

```v
fn main() {
    println(add(2, 3))
}

fn add(a int, b int) int {
    return a + b
}
```

## Avanti

[Commenti](ch03-04-comments.md)
