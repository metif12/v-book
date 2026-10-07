# मैप

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

## मैप ऑपरेशन

```v
fn main() {
    mut m := {'a': 1, 'b': 2}
    m.delete('a')
    println(m)
    println('a' in m)
}
```

## अगला

[स्ट्रिंग](ch08-03-strings.md)
