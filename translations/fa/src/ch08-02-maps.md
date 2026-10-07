# نقشه‌ها

```v
fn main() {
    mut ages := {
        'Alice': 30
        'Bob':   25
    }
    ages['Charlie'] = 35
    println(ages)
    println(ages['Alice'])
}
```

## عملیات نقشه

```v
fn main() {
    mut m := {'a': 1, 'b': 2}
    m.delete('a')
    println(m)
    println('a' in m)
}
```

## بعدی

[رشته‌ها](ch08-03-strings.md)
