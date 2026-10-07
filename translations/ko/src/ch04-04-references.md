# 참조

큰 데이터의 복사를 피하기 위해 참조를 사용합니다:

```v
fn modify(mut arr []int) {
    arr << 42
}

fn main() {
    mut data := [1, 2, 3]
    modify(mut data)
    println(data)
}
```

## 다음

[Chapter 5: Struct](ch05-structs.md)
