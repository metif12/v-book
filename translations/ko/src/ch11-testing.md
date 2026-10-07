# Chapter 11: 테스팅

V에는 내장 테스팅 프레임워크가 있습니다.

## 테스트 파일

`_test.v`로 끝나는 파일을 생성하세요:

```v
fn add(a int, b int) int {
    return a + b
}

fn test_add() {
    assert add(2, 3) == 5
    assert add(-1, 1) == 0
}
```

## 테스트 실행

```bash
v test .
```

## 테스트 구성

```v
fn add(a int, b int) int {
    return a + b
}

fn sub(a int, b int) int {
    return a - b
}

fn mul(a int, b int) int {
    return a * b
}

fn test_add() {
    assert add(2, 3) == 5
}

fn test_sub() {
    assert sub(5, 3) == 2
}

fn test_mul() {
    assert mul(2, 3) == 6
}
```

## 테이블 기반 테스트

```v
fn add(a int, b int) int {
    return a + b
}

fn test_add() {
    tests := [
        [2, 3, 5],
        [-1, 1, 0],
        [0, 0, 0],
    ]
    for t in tests {
        assert add(t[0], t[1]) == t[2]
    }
}
```

## 요약

이 장에서는 V의 테스팅 프레임워크에 대해 배웠습니다. 다음 장에서는 명령줄 도구를 만들어보겠습니다.
