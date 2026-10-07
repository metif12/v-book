# 접근 제어자

필드는 기본적으로 private입니다:

```v
struct User {
    name string
pub:
    age int
}

fn main() {
    u := User{name: 'Alice', age: 30}
    println(u.name)  // OK: 같은 모듈
    println(u.age)   // OK: public
}
```

## 가시성

| 제어자 | 범위 |
|----------|-------|
| (없음) | 모듈 내부만 |
| `pub` | Public |

## 다음

[Chapter 6: Enum과 Sum Type](ch06-enums-and-sum-types.md)
