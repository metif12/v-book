# Kapitel 3: Häufige Konzepte

Dieses Kapitel behandelt die häufigen Programmierkonzepte in V: Variablen, Datentypen, Funktionen, Kommentare und Kontrollfluss.

## Variablen und Veränderbarkeit

In V sind Variablen standardmäßig unveränderlich. Verwenden Sie `mut`, um sie veränderbar zu machen:

```v
fn main() {
    name := 'V'
    // name = 'Go'  // Fehler: name is immutable

    mut count := 0
    count = 1  // OK: count is mutable
    count++
    println(count)
}
```

## Datentypen

V verfügt über ein umfangreiches Typsystem:

```v
fn main() {
    // Ganzzahlen
    a := 42        // int
    b := i64(100)  // 64-bit integer
    c := u8(255)   // unsigned 8-bit

    // Gleitkommazahlen
    pi := 3.14     // f64
    e := f32(2.71) // 32-bit float

    // Andere Typen
    name := 'V'    // string
    is_ok := true  // bool
    letter := `A`  // rune (single character)

    println('${a} ${b} ${c}')
    println('${pi} ${e}')
    println('${name} ${is_ok} ${letter}')
}
```

## Funktionen

Funktionen werden mit `fn` deklariert:

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

## Kommentare

```v
// This is a line comment

/* This is a
   block comment */
```

## Kontrollfluss

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

### For-Schleife

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

## Zusammenfassung

In diesem Kapitel haben Sie Variablen, Datentypen, Funktionen, Kommentare und Kontrollfluss in V kennengelernt. Im nächsten Kapitel untersuchen wir Ownership und Speicherverwaltung.
