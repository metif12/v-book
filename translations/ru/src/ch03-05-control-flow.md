# Управляющие конструкции

## If

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

## If как выражение

```v
fn main() {
    age := 25
    category := if age >= 18 { 'adult' } else { 'minor' }
    println(category)
}
```

## Цикл for

```v
fn main() {
    // По массиву
    fruits := ['apple', 'banana', 'cherry']
    for fruit in fruits {
        println(fruit)
    }

    // По диапазону
    for i in 0 .. 5 {
        println(i)
    }

    // С индексом
    for i, fruit in fruits {
        println('${i}: ${fruit}')
    }
}
```

## Match

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

## Далее

[Глава 4: Владение и память](ch04-ownership-and-memory.md)
