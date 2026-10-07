# v test로 테스트하기

V에는 내장 테스팅 프레임워크가 있습니다. `_test.v`로 끝나는 파일을 생성하세요:

```v
fn add(a int, b int) int {
    return a + b
}

fn test_add() {
    assert add(2, 3) == 5
    assert add(-1, 1) == 0
}
```

테스트 실행:

```bash
v test .
```

## 테스트 함수

테스트 함수는 `test_`로 시작하며 인자를 받지 않습니다:

```v
fn test_something() {
    assert true
}
```

## 어서션

`assert`를 사용하여 조건을 확인하세요:

```v
fn test_math() {
    assert 1 + 1 == 2
    assert 2 * 3 == 6
}
```

## 다음

[Chapter 3: 공통 개념](ch03-common-concepts.md)
