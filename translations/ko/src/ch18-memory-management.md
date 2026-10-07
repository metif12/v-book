# Chapter 18: 메모리 관리 심화

## GC 모드

V는 각기 다른 사용 사례에 적합한 여러 메모리 관리 전략을 제공합니다.

| 모드 | 플래그 | 사용 사례 |
|------|------|----------|
| Boehm GC | `-gc boehm` | 범용 |
| Autofree | `-autofree` | 자동 해제 |
| None | `-gc none` | 수동 관리 |
| Prealloc | `-prealloc` | 아레나 할당 |

## 스택 vs 힙

V는 메모리를 할당할 위치를 자동으로 결정합니다. 작고 수명이 짧은 값은 스택에 유지됩니다. 더 크거나 이스케이프된 값은 힙에 갑니다.

```v
fn stack_example() int {
    x := 42
    y := x * 2
    return y
}

fn heap_example() []int {
    data := []int{len: 100, init: 0}
    return data
}

fn main() {
    a := stack_example()
    b := heap_example()
    println(a)
    println(b.len)
}
```

## Autofree 모드

Autofree는 변수가 스코프를 벗어날 때 메모리를 자동으로 해제합니다. 힙 할당에 참조 카운팅을 사용합니다.

```v
fn create_user(name string) string {
    greeting := 'Hello, ${name}!'
    return greeting
}

fn main() {
    msg := create_user('World')
    println(msg)
}
```

## -gc none과 수동 메모리

`-gc none`을 사용하면 V는 가비지 컬렉션을 비활성화합니다. `free`를 사용하여 메모리를 수동으로 관리해야 합니다.

```v
fn main() {
    mut data := []int{len: 1000, init: 0}
    for i in 0 .. 1000 {
        data[i] = i * 2
    }
    println(data[500])
    unsafe {
        data.free()
    }
}
```

## -prealloc 아레나 할당

Prealloc은 타이트 루프에서 더 나은 성능을 위해 아레나 할당을 사용합니다. 할당이 일괄적으로 해제됩니다.

```v
fn process_items(count int) int {
    mut total := 0
    $if prealloc {
        for i in 0 .. count {
            total += i * i
        }
    } $else {
        for i in 0 .. count {
            total += i * i
        }
    }
    return total
}

fn main() {
    result := process_items(10000)
    println(result)
}
```

## Unsafe 코드

`unsafe` 블록은 포인터 연산과 직접 메모리 접근 등 V의 안전 보장을 우회하는 작업을 허용합니다.

```v
fn main() {
    x := 42
    p := unsafe { &x }
    println(p)
    unsafe {
        q := p + 1
        println(q)
    }
}
```

### 포인터 연산

```v
fn main() {
    arr := [10, 20, 30, 40, 50]
    unsafe {
        p := &arr[0]
        first := p[0]
        second := p[1]
        third := p[2]
        println('${first} ${second} ${third}')
    }
}
```

## 성능 튜닝

적절한 메모리 관리 모드를 선택하면 성능에 상당한 영향을 미칠 수 있습니다.

### 다른 모드 벤치마킹

```v
fn benchmark_allocations(iterations int) i64 {
    sw := i64(0)
    $if boehm ? {
        sw = i64(1)
    }
    $if autofree ? {
        sw = i64(2)
    }
    $if prealloc ? {
        sw = i64(3)
    }
    return sw
}

fn main() {
    mode := benchmark_allocations(1000000)
    println('Mode: ${mode}')
}
```

### 데이터 구조 최적화

```v
struct Point {
    x f64
    y f64
}

fn sum_points(points []Point) f64 {
    mut total := 0.0
    for p in points {
        total += p.x + p.y
    }
    return total
}

fn main() {
    points := []Point{len: 10000, init: Point{x: 1.0, y: 2.0}}
    result := sum_points(points)
    println(result)
}
```

## 요약

이 장에서는 메모리 관리 모드, 스택 vs 힙 할당, autofree, 수동 메모리 관리, prealloc, unsafe 코드, 성능 튜닝에 대해 배웠습니다. 다음 장에서는 도구를 살펴보겠습니다.
