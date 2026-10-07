# مرحباً، V!

لننظر إلى مثال أكثر إثارة للاهتمام:

```v
fn main() {
    name := 'V'
    println('Hello, ${name}!')
    println('${name} is a great language.')
}
```

شغّله:

```bash
v run main.v
```

الناتج:

```
Hello, V!
V is a great language.
```

## استيفاء النصوص

V يستخدم `${...}` لاستيفاء النصوص. أي تعبير داخل `${...}` يُقيَّم ويُحوَّل إلى نص:

```v
fn main() {
    a := 42
    b := 3.14
    println('a = ${a}, b = ${b}')
    println('a + 10 = ${a + 10}')
}
```

## المتغيرات

استخدم `:=` لتعريف وتهيئة متغير:

```v
fn main() {
    name := 'V'
    version := 0.5
    is_awesome := true
    println('${name} v${version} is awesome: ${is_awesome}')
}
```

## التالي

[الفصل 2: بناء مشروع](ch02-building-a-project.md)
