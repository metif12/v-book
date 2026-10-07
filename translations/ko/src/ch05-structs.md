# Chapter 5: Struct

Struct는 V에서 커스텀 데이터 타입을 정의하는 방법입니다.

## Struct 정의하기

```v
struct Point {
    x int
    y int
}

fn main() {
    p := Point{x: 10, y: 20}
    println('(${p.x}, ${p.y})')
}
```

## 메서드

```v
struct Point {
    x int
    y int
}

fn (p Point) str() string {
    return '(${p.x}, ${p.y})'
}

fn main() {
    p := Point{x: 10, y: 20}
    println(p.str())
}
```

## 임베디드 Struct

```v
struct Point {
    x int
    y int
}

struct Circle {
    Point
    radius f64
}

fn main() {
    c := Circle{
        Point: Point{x: 0, y: 0}
        radius: 5.0
    }
    println('(${c.x}, ${c.y}) r=${c.radius}')
}
```

## 접근 제어자

필드는 기본적으로 private입니다. `pub`을 사용하여 public으로 만드세요:

```v
struct User {
    name string
pub:
    age int
}

fn main() {
    u := User{name: 'Alice', age: 30}
    println(u.name)  // OK: 같은 모듈
    println(u.age)   // OK: public
}
```

## 요약

이 장에서는 struct, 메서드, 임베딩, 접근 제어자에 대해 배웠습니다. 다음 장에서는 enum과 sum type을 살펴보겠습니다.
