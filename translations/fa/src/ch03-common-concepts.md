# فصل ۳: مفاهیم رایج

این فصل مفاهیم رایج برنامه‌نویسی در V را پوشش می‌دهد: متغیرها، انواع داده، توابع، کامنت‌ها و کنترل جریان.

## متغیرها و تغییرپذیری

در V، متغیرها به صورت پیش‌فرض غیرقابل تغییر هستند. از `mut` برای قابل تغییر کردن آن‌ها استفاده کنید:

```v
fn main() {
    name := 'V'
    // name = 'Go'  // Error: name is immutable

    mut count := 0
    count = 1  // OK: count is mutable
    count++
    println(count)
}
```

## انواع داده

V یک سیستم نوع غنی دارد:

```v
fn main() {
    // Integers
    a := 42        // int
    b := i64(100)  // 64-bit integer
    c := u8(255)   // unsigned 8-bit

    // Floats
    pi := 3.14     // f64
    e := f32(2.71) // 32-bit float

    // Other types
    name := 'V'    // string
    is_ok := true  // bool
    letter := `A`  // rune (single character)

    println('${a} ${b} ${c}')
    println('${pi} ${e}')
    println('${name} ${is_ok} ${letter}')
}
```

## توابع

توابع با `fn` تعریف می‌شوند:

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

## کامنت‌ها

```v
// This is a line comment

/* This is a
   block comment */
```

## کنترل جریان

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

### حلقه For

```v
fn main() {
    // Loop over an array
    fruits := ['apple', 'banana', 'cherry']
    for fruit in fruits {
        println(fruit)
    }

    // Range loop
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

## خلاصه

در این فصل، درباره متغیرها، انواع داده، توابع، کامنت‌ها و کنترل جریان در V یاد گرفتید. در فصل بعد، به مالکیت و مدیریت حافظه می‌پردازیم.
