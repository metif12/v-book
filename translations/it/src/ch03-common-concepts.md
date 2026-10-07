# Capitolo 3: Concetti Comuni

Questo capitolo copre i concetti di programmazione comuni in V: variabili, tipi di dato, funzioni, commenti e flusso di controllo.

## Variabili e Mutabilità

In V, le variabili sono immutabili per impostazione predefinita. Usa `mut` per renderle mutabili:

```v
fn main() {
    name := 'V'
    // name = 'Go'  // Errore: name è immutabile

    mut count := 0
    count = 1  // OK: count è mutabile
    count++
    println(count)
}
```

## Tipi di Dato

V ha un sistema di tipi ricco:

```v
fn main() {
    // Interi
    a := 42        // int
    b := i64(100)  // intero a 64 bit
    c := u8(255)   // senza segno a 8 bit

    // Float
    pi := 3.14     // f64
    e := f32(2.71) // float a 32 bit

    // Altri tipi
    name := 'V'    // string
    is_ok := true  // bool
    letter := `A`  // rune (carattere singolo)

    println('${a} ${b} ${c}')
    println('${pi} ${e}')
    println('${name} ${is_ok} ${letter}')
}
```

## Funzioni

Le funzioni sono dichiarate con `fn`:

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

## Commenti

```v
// This is a line comment

/* This is a
   block comment */
```

## Flusso di Controllo

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

### Ciclo For

```v
fn main() {
    // Iterazione su un array
    fruits := ['apple', 'banana', 'cherry']
    for fruit in fruits {
        println(fruit)
    }

    // Iterazione su un intervallo
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

## Riassunto

In questo capitolo, hai imparato le variabili, i tipi di dato, le funzioni, i commenti e il flusso di controllo in V. Nel prossimo capitolo, esploreremo ownership e gestione della memoria.
