# कंट्रोल फ़्लो

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

## If एक्सप्रेशन के रूप में

```v
fn main() {
    age := 25
    category := if age >= 18 { 'adult' } else { 'minor' }
    println(category)
}
```

## For loop

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

## अगला

[अध्याय 4: ओनरशिप और मेमोरी](ch04-ownership-and-memory.md)
