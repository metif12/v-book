# Hello, V!

आइए एक अधिक रोचक उदाहरण देखें:

```v
fn main() {
    name := 'V'
    println('Hello, ${name}!')
    println('${name} is a great language.')
}
```

इसे चलाएं:

```bash
v run main.v
```

आउटपुट:

```
Hello, V!
V is a great language.
```

## स्ट्रिंग इंटरपोलेशन

V स्ट्रिंग इंटरपोलेशन के लिए `${...}` का उपयोग करता है। `${...}` के अंदर का कोई भी एक्सप्रेशन मूल्यांकित होता है और स्ट्रिंग में परिवर्तित होता है:

```v
fn main() {
    a := 42
    b := 3.14
    println('a = ${a}, b = ${b}')
    println('a + 10 = ${a + 10}')
}
```

## वेरिएबल

वेरिएबल घोषित करने और इनिशियलाइज़ करने के लिए `:=` का उपयोग करें:

```v
fn main() {
    name := 'V'
    version := 0.5
    is_awesome := true
    println('${name} v${version} is awesome: ${is_awesome}')
}
```

## अगला

[अध्याय 2: प्रोजेक्ट बनाना](ch02-building-a-project.md)
