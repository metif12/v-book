# توابع

توابع با `fn` تعریف می‌شوند:

```v
fn add(a int, b int) int {
    return a + b
}

fn main() {
    result := add(2, 3)
    println(result)
}
```

## چندین مقدار بازگشتی

```v
fn divmod(a int, b int) (int, int) {
    return a / b, a % b
}

fn main() {
    q, r := divmod(17, 5)
    println('quotient: ${q}, remainder: ${r}')
}
```

## بدون مقدار بازگشتی

```v
fn greet(name string) {
    println('Hello, ${name}!')
}

fn main() {
    greet('World')
}
```

## بالا بردن تابع

توابع را می‌توان قبل از تعریف آن‌ها فراخوانی کرد:

```v
fn main() {
    println(add(2, 3))
}

fn add(a int, b int) int {
    return a + b
}
```

## بعدی

[کامنت‌ها](ch03-04-comments.md)
