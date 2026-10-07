# Bab 3: Konsep Umum

Bab ini membahas konsep pemrograman umum dalam V: variabel, tipe data, fungsi, komentar, dan alur kontrol.

## Variabel dan Mutabilitas

Dalam V, variabel bersifat immutable secara default. Gunakan `mut` untuk membuatnya mutable:

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

## Tipe Data

V memiliki sistem tipe yang kaya:

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

## Fungsi

Fungsi dideklarasikan dengan `fn`:

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

## Komentar

```v
// This is a line comment

/* This is a
   block comment */
```

## Alur Kontrol

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

## Ringkasan

Dalam bab ini, Anda telah belajar tentang variabel, tipe data, fungsi, komentar, dan alur kontrol dalam V. Di bab berikutnya, kita akan menjelajahi kepemilikan dan manajemen memori.
