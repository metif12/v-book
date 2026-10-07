# Глава 3: Общие концепции

Эта глава охватывает общие концепции программирования на V: переменные, типы данных, функции, комментарии и управляющие конструкции.

## Переменные и изменяемость

В V переменные по умолчанию неизменяемы. Используйте `mut`, чтобы сделать их изменяемыми:

```v
fn main() {
    name := 'V'
    // name = 'Go'  // Ошибка: name неизменяема

    mut count := 0
    count = 1  // OK: count изменяема
    count++
    println(count)
}
```

## Типы данных

В V богатая система типов:

```v
fn main() {
    // Целые числа
    a := 42        // int
    b := i64(100)  // 64-битное целое
    c := u8(255)   // беззнаковое 8-битное

    // Числа с плавающей точкой
    pi := 3.14     // f64
    e := f32(2.71) // 32-битное с плавающей точкой

    // Другие типы
    name := 'V'    // string
    is_ok := true  // bool
    letter := `A`  // rune (один символ)

    println('${a} ${b} ${c}')
    println('${pi} ${e}')
    println('${name} ${is_ok} ${letter}')
}
```

## Функции

Функции объявляются с помощью `fn`:

```v
fn add(a int, b int) int {
    return a + b
}

fn greet(name string) {
    println('Hello, ${name}!')
}

fn main() {
    result := add(2, 3)
    println(result)
    greet('World')
}
```

## Комментарии

```v
// This is a line comment

/* This is a
   block comment */
```

## Управляющие конструкции

### If

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

### Цикл for

```v
fn main() {
    // Цикл по массиву
    fruits := ['apple', 'banana', 'cherry']
    for fruit in fruits {
        println(fruit)
    }

    // Цикл по диапазону
    for i in 0 .. 5 {
        println(i)
    }
}
```

### Match

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

## Итоги

В этой главе вы узнали о переменных, типах данных, функциях, комментариях и управляющих конструкциях в V. В следующей главе мы рассмотрим владение и управление памятью.
