# Chapter 13: 함수형 기능

V는 클로저와 고차 함수를 지원합니다.

## 클로저

```v
fn main() {
    add := fn (a int, b int) int {
        return a + b
    }
    println(add(2, 3))
}
```

## 고차 함수

```v
fn apply(f fn (int) int, x int) int {
    return f(x)
}

fn main() {
    double := fn (x int) int {
        return x * 2
    }
    println(apply(double, 5))
}
```

## 익명 함수

```v
fn main() {
    nums := [1, 2, 3, 4, 5]
    doubled := nums.map(fn (x int) int {
        return x * 2
    })
    println(doubled)
}
```

## 요약

이 장에서는 클로저와 고차 함수에 대해 배웠습니다. 다음 장에서는 동시성을 살펴보겠습니다.
