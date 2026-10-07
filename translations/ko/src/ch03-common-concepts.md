# Chapter 3: 공통 개념

이 장에서는 V의 일반적인 프로그래밍 개념을 다룹니다: 변수, 데이터 타입, 함수, 주석, 제어 흐름.

## 변수와 가변성

V에서 변수는 기본적으로 불변입니다. 가변으로 만들려면 `mut`을 사용하세요:

```v
fn main() {
    name := 'V'
    // name = 'Go'  // 에러: name은 불변입니다

    mut count := 0
    count = 1  // OK: count는 가변입니다
    count++
    println(count)
}
```

## 데이터 타입

V는 풍부한 타입 시스템을 가집니다:

```v
fn main() {
    // 정수
    a := 42        // int
    b := i64(100)  // 64비트 정수
    c := u8(255)   // 부호 없는 8비트

    // 부동소수점
    pi := 3.14     // f64
    e := f32(2.71) // 32비트 부동소수점

    // 기타 타입
    name := 'V'    // string
    is_ok := true  // bool
    letter := `A`  // rune (단일 문자)

    println('${a} ${b} ${c}')
    println('${pi} ${e}')
    println('${name} ${is_ok} ${letter}')
}
```

## 함수

함수는 `fn`으로 선언합니다:

```v
fn add(a int, b int) int {
    return a + b
}

fn greet(name string) {
    println('Hello, ${name}!')
}

fn main() {
    result := add(2, 3)
    println(result)
    greet('World')
}
```

## 주석

```v
// This is a line comment

/* This is a
   block comment */
```

## 제어 흐름

### If

```v
fn main() {
    age := 25
    if age >= 18 {
        println('Adult')
    } else {
        println('Minor')
    }
}
```

### For 루프

```v
fn main() {
    // 배열 순회
    fruits := ['apple', 'banana', 'cherry']
    for fruit in fruits {
        println(fruit)
    }

    // 범위 루프
    for i in 0 .. 5 {
        println(i)
    }
}
```

### Match

```v
fn main() {
    color := 'blue'
    match color {
        'red' { println('Red!') }
        'blue' { println('Blue!') }
        else { println('Other color') }
    }
}
```

## 요약

이 장에서는 V의 변수, 데이터 타입, 함수, 주석, 제어 흐름에 대해 배웠습니다. 다음 장에서는 소유권과 메모리 관리를 살펴보겠습니다.
