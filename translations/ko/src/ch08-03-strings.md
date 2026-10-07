# 문자열

```v
fn main() {
    s := 'Hello, World!'
    println(s.len)
    println(s[0])
    println(s.contains('World'))
    println(s.to_upper())
}
```

## 문자열 메서드

```v
fn main() {
    s := '  hello  '
    println(s.trim_space())
    println(s.split(','))
    println(s.replace('l', 'L'))
}
```

## 다음

[Chapter 9: 에러 처리](ch09-error-handling.md)
