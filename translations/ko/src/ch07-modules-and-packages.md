# Chapter 7: 모듈과 패키지

## 모듈 시스템

V는 코드를 모듈로 구성합니다. 모듈은 `.v` 파일이 있는 디렉터리입니다:

```
my_project/
├── v.mod
├── main.v
└── math/
    └── math.v
```

`math/math.v`:

```v ignore
module math

pub fn add(a int, b int) int {
    return a + b
}
```

`main.v`:

```v ignore
import math

fn main() {
    println(math.add(2, 3))
}
```

## 가시성

- `pub` — public, 다른 모듈에서 접근 가능
- (제어자 없음) — private, 모듈 내부만

## VPM

V Package Manager(VPM)는 커뮤니티 패키지를 호스팅합니다:

```bash
v install vsl
```

## 요약

이 장에서는 모듈, 가시성, VPM에 대해 배웠습니다. 다음 장에서는 컬렉션을 살펴보겠습니다.
