# Hello, V!

조금 더 흥미로운 예제를 살펴봅시다:

```v
fn main() {
    name := 'V'
    println('Hello, ${name}!')
    println('${name} is a great language.')
}
```

실행하세요:

```bash
v run main.v
```

출력:

```
Hello, V!
V is a great language.
```

## 문자열 보간

V는 문자열 보간에 `${...}`을 사용합니다. `${...}` 안의 모든 표현식은 평가되어 문자열로 변환됩니다:

```v
fn main() {
    a := 42
    b := 3.14
    println('a = ${a}, b = ${b}')
    println('a + 10 = ${a + 10}')
}
```

## 변수

`:=`를 사용하여 변수를 선언하고 초기화합니다:

```v
fn main() {
    name := 'V'
    version := 0.5
    is_awesome := true
    println('${name} v${version} is awesome: ${is_awesome}')
}
```

## 다음

[Chapter 2: 프로젝트 구성하기](ch02-building-a-project.md)
