# الدوال

الدوال تُعرّف بـ `fn`:

```v
fn add(a int, b int) int {
    return a + b
}

fn main() {
    result := add(2, 3)
    println(result)
}
```

## قيم إرجاع متعددة

```v
fn divmod(a int, b int) (int, int) {
    return a / b, a % b
}

fn main() {
    q, r := divmod(17, 5)
    println('quotient: ${q}, remainder: ${r}')
}
```

## بدون قيمة إرجاع

```v
fn greet(name string) {
    println('Hello, ${name}!')
}

fn main() {
    greet('World')
}
```

## رفع الدوال

يمكن استدعاء الدوال قبل تعريفها:

```v
fn main() {
    println(add(2, 3))
}

fn add(a int, b int) int {
    return a + b
}
```

## التالي

[التعليقات](ch03-04-comments.md)
