# Fonctions

Les fonctions sont déclarées avec `fn` :

```v
fn add(a int, b int) int {
    return a + b
}

fn main() {
    result := add(2, 3)
    println(result)
}
```

## Valeurs de retour multiples

```v
fn divmod(a int, b int) (int, int) {
    return a / b, a % b
}

fn main() {
    q, r := divmod(17, 5)
    println('quotient: ${q}, remainder: ${r}')
}
```

## Sans valeur de retour

```v
fn greet(name string) {
    println('Hello, ${name}!')
}

fn main() {
    greet('World')
}
```

## Hissement de fonctions

Les fonctions peuvent être appelées avant leur déclaration :

```v
fn main() {
    println(add(2, 3))
}

fn add(a int, b int) int {
    return a + b
}
```

## Suivant

[Commentaires](ch03-04-comments.md)
