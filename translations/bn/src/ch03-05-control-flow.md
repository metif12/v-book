# কন্ট্রোল ফ্লো

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

## If এক্সপ্রেশন হিসেবে

```v
fn main() {
    age := 25
    category := if age >= 18 { 'adult' } else { 'minor' }
    println(category)
}
```

## For লুপ

```v
fn main() {
    // Over an array
    fruits := ['apple', 'banana', 'cherry']
    for fruit in fruits {
        println(fruit)
    }

    // Range
    for i in 0 .. 5 {
        println(i)
    }

    // With index
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

## পরবর্তী

[অধ্যায় 4: ওনারশিপ এবং মেমোরি](ch04-ownership-and-memory.md)
