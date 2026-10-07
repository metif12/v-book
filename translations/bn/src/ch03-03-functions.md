# ফাংশন

ফাংশন `fn` দিয়ে ঘোষণা করা হয়:

```v
fn add(a int, b int) int {
    return a + b
}

fn main() {
    result := add(2, 3)
    println(result)
}
```

## একাধিক রিটার্ন মান

```v
fn divmod(a int, b int) (int, int) {
    return a / b, a % b
}

fn main() {
    q, r := divmod(17, 5)
    println('quotient: ${q}, remainder: ${r}')
}
```

## রিটার্ন মান নেই

```v
fn greet(name string) {
    println('Hello, ${name}!')
}

fn main() {
    greet('World')
}
```

## ফাংশন হোইস্টিং

ফাংশন ঘোষণার আগেই কল করা যায়:

```v
fn main() {
    println(add(2, 3))
}

fn add(a int, b int) int {
    return a + b
}
```

## পরবর্তী

[কমেন্ট](ch03-04-comments.md)
