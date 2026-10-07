# फ़ंक्शन

फ़ंक्शन `fn` के साथ घोषित किए जाते हैं:

```v
fn add(a int, b int) int {
    return a + b
}

fn main() {
    result := add(2, 3)
    println(result)
}
```

## एकाधिक रिटर्न मान

```v
fn divmod(a int, b int) (int, int) {
    return a / b, a % b
}

fn main() {
    q, r := divmod(17, 5)
    println('quotient: ${q}, remainder: ${r}')
}
```

## कोई रिटर्न मान नहीं

```v
fn greet(name string) {
    println('Hello, ${name}!')
}

fn main() {
    greet('World')
}
```

## फ़ंक्शन होइस्टिंग

फ़ंक्शन को उनकी घोषणा से पहले कॉल किया जा सकता है:

```v
fn main() {
    println(add(2, 3))
}

fn add(a int, b int) int {
    return a + b
}
```

## अगला

[कमेंट्स](ch03-04-comments.md)
