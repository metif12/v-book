# 변수와 가변성

V에서 변수는 기본적으로 불변입니다:

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

## 선언

`:=`를 사용하여 선언하고 초기화합니다:

```v
x := 42
name := 'V'
is_ready := true
```

## 타입 추론

V는 초기화 표현식에서 타입을 추론합니다:

```v
a := 42      // int
b := 3.14    // f64
c := 'hello' // string
d := true    // bool
```

## 명시적 타입

타입을 명시적으로 지정할 수 있습니다:

```v
a := i64(42)
b := f32(3.14)
c := u8(255)
```

## 다음

[데이터 타입](ch03-02-data-types.md)
