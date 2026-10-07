# Hello, World!

`main.v` 파일을 생성하세요:

```v
fn main() {
    println('Hello, World!')
}
```

실행하세요:

```bash
v run main.v
```

출력:

```
Hello, World!
```

## V 프로그램의 구조

프로그램을 분석해봅시다:

- `fn main()` — 모든 V 프로그램은 `main` 함수로 시작합니다. `fn` 키워드는 함수를 선언합니다.
- `println(...)` — stdout에 한 줄을 출력하는 내장 함수입니다.
- `'Hello, World!'` — 문자열 리터럴입니다. V는 문자열에 작은따옴표를 사용합니다.

## 컴파일 vs 실행

`v run`은 한 단계로 컴파일하고 실행합니다. 먼저 컴파일할 수도 있습니다:

```bash
v main.v
./main
```

## 다음

[Hello, V!](ch01-03-hello-v.md)
