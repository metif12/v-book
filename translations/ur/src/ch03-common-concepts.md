# باب ۳: عام تصورات

یہ باب V کی عام پروگرامنگ تصورات کو چھوتا ہے: متغیرات، ڈیٹا کی اقسام، فنکشنز، تبصرے، اور کنٹرول فلو۔

## متغیرات اور تبدیلی پذیری

V میں، متغیرات ڈیفالٹ طور پر غیر تبدیل پذیر ہوتے ہیں۔ انہیں تبدیل پذیر بنانے کے لیے `mut` استعمال کریں:

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

## ڈیٹا کی اقسام

V کے پاس ایک مکمل ٹائپ سسٹم ہے:

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

## فنکشنز

فنکشنز `fn` سے تعریف کیے جاتے ہیں:

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

## تبصرے

```v
// This is a line comment

/* This is a
   block comment */
```

## کنٹرول فلو

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

### For لوپ

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

## خلاصہ

اس باب میں، آپ نے V میں متغیرات، ڈیٹا کی اقسام، فنکشنز، تبصرے، اور کنٹرول فلو کے بارے میں سیکھا۔ اگلے باب میں، ہم ملکیت اور میموری مینجمنٹ کو دریافت کریں گے۔
