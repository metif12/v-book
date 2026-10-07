# अध्याय 3: सामान्य अवधारणाएँ

यह अध्याय V की सामान्य प्रोग्रामिंग अवधारणाओं को कवर करता है: वेरिएबल, डेटा टाइप्स, फ़ंक्शन, कमेंट्स, और कंट्रोल फ़्लो।

## वेरिएबल और म्यूटेबिलिटी

V में, वेरिएबल डिफ़ॉल्ट रूप से इम्यूटेबल होते हैं। उन्हें म्यूटेबल बनाने के लिए `mut` का उपयोग करें:

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

## डेटा टाइप्स

V में एक समृद्ध टाइप सिस्टम है:

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

## फ़ंक्शन

फ़ंक्शन `fn` के साथ घोषित किए जाते हैं:

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

## कमेंट्स

```v
// This is a line comment

/* This is a
   block comment */
```

## कंट्रोल फ़्लो

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

## सारांश

इस अध्याय में, आपने V में वेरिएबल, डेटा टाइप्स, फ़ंक्शन, कमेंट्स, और कंट्रोल फ़्लो के बारे में सीखा। अगले अध्याय में, हम ओनरशिप और मेमोरी मैनेजमेंट का पता लगाएंगे।
