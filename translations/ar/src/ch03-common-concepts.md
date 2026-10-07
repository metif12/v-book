# الفصل 3: المفاهيم الشائعة

يغطي هذا الفصل مفاهيم البرمجة الشائعة في V: المتغيرات، أنواع البيانات، الدوال، التعليقات، والتحكم في التدفق.

## المتغيرات والتغيير

في V، المتغيرات غير قابلة للتغيير افتراضياً. استخدم `mut` لجعلها قابلة للتغيير:

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

## أنواع البيانات

V لديه نظام أنواع غني:

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

## الدوال

الدوال تُعرّف بـ `fn`:

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

## التعليقات

```v
// This is a line comment

/* This is a
   block comment */
```

## التحكم في التدفق

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

### For loop

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

## الملخص

في هذا الفصل، تعلمت عن المتغيرات، أنواع البيانات، الدوال، التعليقات، والتحكم في التدفق في V. في الفصل التالي، سنستكشف الملكية وإدارة الذاكرة.
