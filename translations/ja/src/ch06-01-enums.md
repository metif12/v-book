# enum

```v
enum Color {
    red
    green
    blue
}

fn main() {
    c := Color.red
    println(c)
    match c {
        .red { println('Red!') }
        .green { println('Green!') }
        .blue { println('Blue!') }
    }
}
```

## 次へ

[sum型](ch06-02-sum-types.md)
