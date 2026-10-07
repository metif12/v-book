# Chapter 17: 고급 기능

## 어트리뷰트

어트리뷰트는 선언 앞에 위치하는 메타데이터 어노테이션입니다. 컴파일러 동작, 최적화 힌트, API 수명 주기를 제어합니다.

### [deprecated]

함수나 타입을 더 이상 사용되지 않음으로 표시합니다. 항목이 사용될 때 컴파일러가 경고를 발생시킵니다.

```v
[deprecated]
fn old_add(a int, b int) int {
    return a + b
}

[deprecated: 'Use new_add instead']
fn old_multiply(a int, b int) int {
    return a * b
}
```

### [inline]

컴파일러가 호출 사이트에서 함수를 인라인하도록 힌트를 제공합니다. 작고 자주 호출되는 함수에 적합합니다.

```v
[inline]
fn square(x int) int {
    return x * x
}

fn main() {
    result := square(5)
    println(result)
}
```

### [unsafe]

함수를 unsafe로 표시하여 호출자도 unsafe로 표시하지 않고 `unsafe` 블록을 사용할 수 있게 합니다.

```v
[unsafe]
fn read_pointer(ptr voidptr) int {
    return unsafe { *(&int(ptr)) }
}

fn main() {
    x := 42
    val := read_pointer(&x)
    println(val)
}
```

### [if]

컴파일 타임의 조건부 컴파일입니다. 조건이 참일 때만 블록이 포함됩니다.

```v
$if debug {
    println('Debug mode enabled')
} $else {
    println('Release mode')
}
```

## 컴파일 타임 코드

V는 컴파일 중에 실행되는 여러 컴파일 타임 구문을 제공하여 메타프로그래밍과 제로 비용 추상화를 가능하게 합니다.

### $if

컴파일 타임에 조건을 평가합니다. 플랫폼 감지, 아키텍처 확인, 커스텀 플래그를 지원합니다.

```v
$if windows {
    const os_name = 'Windows'
} $else $if macos {
    const os_name = 'macOS'
} $else $if linux {
    const os_name = 'Linux'
} $else {
    const os_name = 'Unknown'
}

fn main() {
    println('Running on ${os_name}')
}
```

### $for

컴파일 타임에 배열, struct 필드, 범위를 반복합니다. 반복적인 코드 생성에 유용합니다.

```v
const platforms = ['windows', 'linux', 'macos']

fn is_platform(name string) bool {
    return name in platforms
}

fn main() {
    println(is_platform('windows'))
    println(is_platform('linux'))
    println(is_platform('macos'))
    println(is_platform('freebsd'))
}
```

### $assert

조건이 거짓이면 컴파일을 중단하는 컴파일 타임 어서션입니다.

```v
$assert sizeof(int) == 8 || sizeof(int) == 4
$assert @VMOD_FILE.len > 0

fn main() {
    println('Assertions passed')
}
```

## 연산자 오버로딩

V는 사용자 정의 타입의 연산자에 대한 커스텀 동작을 정의할 수 있습니다. 각 연산자는 특정 시그니처를 가진 메서드에 매핑됩니다.

### 산술 연산자

```v
struct Vec2 {
    x f64
    y f64
}

fn (a Vec2) + (b Vec2) Vec2 {
    return Vec2{x: a.x + b.x, y: a.y + b.y}
}

fn (a Vec2) - (b Vec2) Vec2 {
    return Vec2{x: a.x - b.x, y: a.y - b.y}
}

fn (a Vec2) * (b Vec2) Vec2 {
    return Vec2{x: a.x * b.x, y: a.y * b.y}
}

fn (a Vec2) / (b Vec2) Vec2 {
    return Vec2{x: a.x / b.x, y: a.y / b.y}
}

fn main() {
    a := Vec2{x: 10, y: 20}
    b := Vec2{x: 2, y: 4}
    sum := a + b
    diff := a - b
    prod := a * b
    quot := a / b
    println('Sum: ${sum.x}, ${sum.y}')
    println('Diff: ${diff.x}, ${diff.y}')
    println('Prod: ${prod.x}, ${prod.y}')
    println('Quot: ${quot.x}, ${quot.y}')
}
```

### 비교 연산자

```v
struct Money {
    amount   f64
    currency string
}

fn (a Money) == (b Money) bool {
    return a.amount == b.amount && a.currency == b.currency
}

fn main() {
    a := Money{amount: 10.0, currency: 'USD'}
    b := Money{amount: 10.0, currency: 'USD'}
    c := Money{amount: 20.0, currency: 'USD'}
    println(a == b)
    println(a == c)
}
```

### 인덱스 연산자

```v
struct Grid {
    data [][]int
}

fn (g Grid) row_count() int {
    return g.data.len
}

fn (g Grid) get(row int, col int) int {
    return g.data[row][col]
}

fn main() {
    g := Grid{
        data: [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
    }
    println(g.row_count())
    println(g.get(1, 2))
}
```

## 컴파일 타임 리플렉션

V의 `$for` 구문은 컴파일 타임에 struct 필드를 반복할 수 있어 자동 직렬화, 유효성 검사 등을 가능하게 합니다.

### struct 필드 반복

```v
struct User {
    id    int
    name  string
    email string
    age   int
}

fn main() {
    u := User{
        id: 1
        name: 'Alice'
        email: 'alice@example.com'
        age: 30
    }
    $for field in User.fields {
        $if field.typ is string {
            println('${field.name} is a string field')
        } $else $if field.typ is int {
            println('${field.name} is an int field')
        }
    }
    println('${u.name} is ${u.age} years old')
}
```

### 유효성 검사 코드 생성

```v
struct Config {
    host    string
    port    int
    timeout f64
}

fn validate_config(c Config) ! {
    $for field in Config.fields {
        $if field.typ is string {
            if c.$(field.name).len == 0 {
                return error('${field.name} must not be empty')
            }
        } $else $if field.typ is int {
            if c.$(field.name) <= 0 {
                return error('${field.name} must be positive')
            }
        }
    }
}

fn main() {
    cfg := Config{
        host: 'localhost'
        port: 8080
        timeout: 30.0
    }
    validate_config(cfg) or {
        println('Config invalid: ${err}')
        return
    }
    println('Config is valid')
}
```

## 요약

이 장에서는 어트리뷰트, 컴파일 타임 코드, 연산자 오버로딩, 컴파일 타임 리플렉션에 대해 배웠습니다. 이러한 기능은 강력한 메타프로그래밍 패턴과 컴파일에 대한 세밀한 제어를 가능하게 합니다. 다음 장에서는 메모리 관리를 심화하여 살펴보겠습니다.
