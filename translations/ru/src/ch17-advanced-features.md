# Глава 17: Продвинутые возможности

## Атрибуты

Атрибуты — это метаданные, размещаемые перед объявлениями. Они управляют поведением компилятора, подсказками оптимизации и жизненным циклом API.

### [deprecated]

Отмечает функцию или тип как устаревший. Компилятор выдаёт предупреждение при использовании элемента.

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

Подсказывает компилятору встроить функцию в место вызова, устраняя накладные расходы на вызов. Лучше всего подходит для небольших, часто вызываемых функций.

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

Отмечает функцию как небезопасную, позволяя использовать блоки `unsafe` без необходимости помечать вызывающую сторону как unsafe.

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

Условная компиляция на этапе компиляции. Блок включается только при истинности условия.

```v
$if debug {
    println('Debug mode enabled')
} $else {
    println('Release mode')
}
```

## Код на этапе компиляции

V предоставляет несколько конструкций времени компиляции, которые выполняются во время компиляции, обеспечивая метапрограммирование и абстракции с нулевыми накладными расходами.

### $if

Вычисляет условия на этапе компиляции. Поддерживает определение платформы, проверку архитектуры и пользовательские флаги.

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

Итерирует на этапе компиляции по массивам, полям структур или диапазонам. Полезно для генерации повторяющегося кода.

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

Проверки на этапе компиляции, прерывающие компиляцию при ложности условия.

```v
$assert sizeof(int) == 8 || sizeof(int) == 4
$assert @VMOD_FILE.len > 0

fn main() {
    println('Assertions passed')
}
```

## Перегрузка операторов

V позволяет определять пользовательское поведение операторов для пользовательских типов. Каждый оператор соответствует методу с определённой сигнатурой.

### Арифметические операторы

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

### Операторы сравнения

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

### Оператор индексации

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

## Рефлексия на этапе компиляции

Конструкция `$for` в V может итерировать по полям структур на этапе компиляции, обеспечивая автоматическую сериализацию, валидацию и многое другое.

### Итерация по полям структуры

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

### Генерация кода валидации

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

## Итоги

В этой главе вы узнали об атрибутах, коде на этапе компиляции, перегрузке операторов и рефлексии на этапе компиляции. Эти возможности обеспечивают мощные метапрограммирующие паттерны и детальный контроль над компиляцией. В следующей главе мы подробно рассмотрим управление памятью.
