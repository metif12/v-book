# Functions

Functions are declared with `fn`:

```v
fn add(a int, b int) int {
    return a + b
}

fn main() {
    result := add(2, 3)
    println(result)
}
```

## Multiple return values

```v
fn divmod(a int, b int) (int, int) {
    return a / b, a % b
}

fn main() {
    q, r := divmod(17, 5)
    println('quotient: ${q}, remainder: ${r}')
}
```

## No return value

```v
fn greet(name string) {
    println('Hello, ${name}!')
}

fn main() {
    greet('World')
}
```

## Function hoisting

Functions can be called before they are declared:

```v
fn main() {
    println(add(2, 3))
}

fn add(a int, b int) int {
    return a + b
}
```

## Next

[Comments](ch03-04-comments.md)
