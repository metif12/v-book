# فنکشنز

فنکشنز `fn` سے تعریف کیے جاتے ہیں:

```v
fn add(a int, b int) int {
    return a + b
}

fn main() {
    result := add(2, 3)
    println(result)
}
```

## متعدد واپسی قدریں

```v
fn divmod(a int, b int) (int, int) {
    return a / b, a % b
}

fn main() {
    q, r := divmod(17, 5)
    println('quotient: ${q}, remainder: ${r}')
}
```

## بغیر واپسی قدر

```v
fn greet(name string) {
    println('Hello, ${name}!')
}

fn main() {
    greet('World')
}
```

## فنکشن ہوسٹنگ

فنکشنز کو ان کی تعریف سے پہلے بھی بلایا جا سکتا ہے:

```v
fn main() {
    println(add(2, 3))
}

fn add(a int, b int) int {
    return a + b
}
```

## اگلا

[تبصرے](ch03-04-comments.md)
