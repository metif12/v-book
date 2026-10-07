# Глава 18: Углублённое управление памятью

## Режимы сборщика мусора

V предоставляет несколько стратегий управления памятью, каждая из которых подходит для разных сценариев использования.

| Режим | Флаг | Сценарий использования |
|-------|------|----------------------|
| Boehm GC | `-gc boehm` | Общего назначения |
| Автоосвобождение | `-autofree` | Автоматическое освобождение |
| Без GC | `-gc none` | Ручное управление |
| Prealloc | `-prealloc` | Выделение памяти из арены |

## Стек и куча

V автоматически решает, где выделять память. Небольшие, недолгоживущие значения остаются в стеке. Большие или выходящие за пределы области видимости значения попадают в кучу.

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

## Режим автоосвобождения

Автоосвобождение автоматически освобождает память, когда переменные выходят из области видимости. Оно использует подсчёт ссылок для выделений в куче.

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

## -gc none и ручное управление памятью

С флагом `-gc none` V отключает сборщик мусора. Вы должны вручную управлять памятью с помощью `free`.

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

## -prealloc — выделение памяти из арены

Prealloc использует выделение памяти из арены для повышения производительности в тесных циклах. Выделения освобождаются пакетно.

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

## Небезопасный код

Блок `unsafe` позволяет выполнять операции, обходящие гарантии безопасности V, такие как арифметика указателей и прямой доступ к памяти.

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

### Арифметика указателей

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

## Настройка производительности

Выбор правильного режима управления памятью может существенно повлиять на производительность.

### Бенчмаркинг различных режимов

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

### Оптимизация структур данных

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

## Итоги

В этой главе вы узнали о режимах управления памятью, выделении в стеке и куче, автоосвобождении, ручном управлении памятью, prealloc, небезопасном коде и настройке производительности. В следующей главе мы рассмотрим инструменты.
