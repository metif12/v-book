# Funções

Funções são declaradas com `fn`:

```v
fn add(a int, b int) int {
    return a + b
}

fn main() {
    result := add(2, 3)
    println(result)
}
```

## Múltiplos valores de retorno

```v
fn divmod(a int, b int) (int, int) {
    return a / b, a % b
}

fn main() {
    q, r := divmod(17, 5)
    println('quotient: ${q}, remainder: ${r}')
}
```

## Sem valor de retorno

```v
fn greet(name string) {
    println('Hello, ${name}!')
}

fn main() {
    greet('World')
}
```

## Hoisting de função

Funções podem ser chamadas antes de serem declaradas:

```v
fn main() {
    println(add(2, 3))
}

fn add(a int, b int) int {
    return a + b
}
```

## Próximo

[Comentários](ch03-04-comments.md)
