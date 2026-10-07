# অধ্যায় 3: সাধারণ ধারণা

এই অধ্যায়ে V-এর সাধারণ প্রোগ্রামিং ধারণা আলোচনা করা হয়েছে: ভেরিয়েবল, ডেটা টাইপ, ফাংশন, কমেন্ট এবং কন্ট্রোল ফ্লো।

## ভেরিয়েবল এবং মিউটেবিলিটি

V-এ ভেরিয়েবল ডিফল্টভাবে অপরিবর্তনীয়। মিউটেবল করতে `mut` ব্যবহার করুন:

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

## ডেটা টাইপ

V-তে একটি সমৃদ্ধ টাইপ সিস্টেম আছে:

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

## ফাংশন

ফাংশন `fn` দিয়ে ঘোষণা করা হয়:

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

## কমেন্ট

```v
// This is a line comment

/* This is a
   block comment */
```

## কন্ট্রোল ফ্লো

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

### For লুপ

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

## সারসংক্ষেপ

এই অধ্যায়ে আপনি V-এর ভেরিয়েবল, ডেটা টাইপ, ফাংশন, কমেন্ট এবং কন্ট্রোল ফ্লো সম্পর্কে শিখেছেন। পরবর্তী অধ্যায়ে আমরা ওনারশিপ এবং মেমোরি ম্যানেজমেন্ট শিখব।
