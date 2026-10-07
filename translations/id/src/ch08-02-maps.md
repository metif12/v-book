# Map

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

## Operasi map

```v
fn main() {
    mut m := {'a': 1, 'b': 2}
    m.delete('a')
    println(m)
    println('a' in m)
}
```

## Berikutnya

[String](ch08-03-strings.md)
