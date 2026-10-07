# ম্যাপ

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

## ম্যাপ অপারেশন

```v
fn main() {
    mut m := {'a': 1, 'b': 2}
    m.delete('a')
    println(m)
    println('a' in m)
}
```

## পরবর্তী

[স্ট্রিং](ch08-03-strings.md)
