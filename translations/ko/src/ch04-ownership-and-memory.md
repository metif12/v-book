# Chapter 4: 소유권과 메모리

V는 많은 언어와 다른 메모리 관리 방식을 취합니다. 수동 메모리 관리나 가비지 컬렉션만 사용하는 대신, V는 여러 가지 전략을 제공합니다.

## 스택과 힙

V는 스택 또는 힙에 할당할지 자동으로 결정합니다:

```v
fn main() {
    // 스택 할당 (작고, 고정 크기)
    x := 42
    arr := [1, 2, 3]

    // 힙 할당 (크고, 동적)
    mut big := []int{}
    for i in 0 .. 1000 {
        big << i
    }

    println('${x} ${arr} ${big.len}')
}
```

## 가비지 컬렉션

V는 기본적으로 가비지 컬렉터를 사용합니다. 메모리를 수동으로 해제할 필요가 없습니다:

```v
fn main() {
    mut names := []string{}
    for i in 0 .. 100 {
        names << 'name ${i}'
    }
    // 더 이상 참조되지 않으면 메모리가 자동으로 해제됩니다
    println(names.len)
}
```

## Autofree

V에는 변수가 스코프를 벗어날 때 메모리를 자동으로 해제하는 autofree 모드가 있습니다:

```bash
v -autofree main.v
```

```v
fn process() {
    mut data := []int{}
    for i in 0 .. 1000 {
        data << i
    }
    // data는 여기서 자동으로 해제됩니다
}

fn main() {
    process()
    println('done')
}
```

## 참조

큰 데이터의 복사를 피하기 위해 참조를 사용할 수 있습니다:

```v
fn modify(mut arr []int) {
    arr << 42
}

fn main() {
    mut data := [1, 2, 3]
    modify(mut data)
    println(data)
}
```

## 메모리 관리 모드

| 모드 | 플래그 | 설명 |
|------|------|-------------|
| GC (기본) | `-gc boehm` | Boehm 가비지 컬렉터 |
| Autofree | `-autofree` | 자동 메모리 해제 |
| None | `-gc none` | 수동 메모리 관리 |
| Prealloc | `-prealloc` | 아레나 할당 |

## 요약

이 장에서는 V의 메모리 관리 옵션에 대해 배웠습니다. 다음 장에서는 struct를 살펴보겠습니다.
