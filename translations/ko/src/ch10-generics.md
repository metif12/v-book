# Chapter 10: 제네릭

제네릭을 사용하면 어떤 타입에도 동작하는 코드를 작성할 수 있습니다.

## 제네릭 함수

```v
fn max[T](a T, b T) T {
    return if a > b { a } else { b }
}

fn main() {
    println(max(3, 7))
    println(max(3.14, 2.71))
}
```

## 제네릭 struct

```v
struct Stack[T] {
    items []T
}

fn (mut s Stack[T]) push(item T) {
    s.items << item
}

fn (s Stack[T]) pop() ?T {
    if s.items.len == 0 {
        return none
    }
    return s.items.pop()
}

fn main() {
    mut s := Stack[int]{}
    s.push(1)
    s.push(2)
    println(s.pop())
}
```

## 타입 제약

```v
fn sum[T](items []T) T {
    mut total := T(0)
    for item in items {
        total += item
    }
    return total
}

fn main() {
    println(sum([1, 2, 3]))
    println(sum([1.0, 2.0, 3.0]))
}
```

## 요약

이 장에서는 제네릭 함수와 struct에 대해 배웠습니다. 다음 장에서는 테스팅을 살펴보겠습니다.
