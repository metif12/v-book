# 가시성

- `pub` — public, 다른 모듈에서 접근 가능
- (제어자 없음) — private, 모듈 내부만

```v ignore
module math

fn private_helper() int {
    return 42
}

pub fn public_function() int {
    return private_helper()
}
```

## 다음

[VPM](ch07-03-vpm.md)
