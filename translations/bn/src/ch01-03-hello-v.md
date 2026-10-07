# Hello, V!

আসুন আরও আকর্ষণীয় একটি উদাহরণ দেখি:

```v
fn main() {
    name := 'V'
    println('Hello, ${name}!')
    println('${name} is a great language.')
}
```

চালান:

```bash
v run main.v
```

আউটপুট:

```
Hello, V!
V is a great language.
```

## স্ট্রিং ইন্টারপোলেশন

V স্ট্রিং ইন্টারপোলেশনের জন্য `${...}` ব্যবহার করে। `${...}`-এর ভেতরের যেকোনো এক্সপ্রেশন মূল্যায়ন করা হয় এবং স্ট্রিং-এ রূপান্তরিত হয়:

```v
fn main() {
    a := 42
    b := 3.14
    println('a = ${a}, b = ${b}')
    println('a + 10 = ${a + 10}')
}
```

## ভেরিয়েবল

ভেরিয়েবল ঘোষণা এবং আরম্ভ করতে `:=` ব্যবহার করুন:

```v
fn main() {
    name := 'V'
    version := 0.5
    is_awesome := true
    println('${name} v${version} is awesome: ${is_awesome}')
}
```

## পরবর্তী

[অধ্যায় 2: প্রজেক্ট তৈরি](ch02-building-a-project.md)
