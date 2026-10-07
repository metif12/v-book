# Chapitre 3 : Concepts courants

Ce chapitre couvre les concepts de programmation courants dans V : variables, types de données, fonctions, commentaires et flux de contrôle.

## Variables et mutabilité

En V, les variables sont immuables par défaut. Utilisez `mut` pour les rendre mutables :

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

## Types de données

V possède un système de types riche :

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

## Fonctions

Les fonctions sont déclarées avec `fn` :

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

## Commentaires

```v
// This is a line comment

/* This is a
   block comment */
```

## Flux de contrôle

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

### Boucle for

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

## Résumé

Dans ce chapitre, vous avez appris les variables, les types de données, les fonctions, les commentaires et le flux de contrôle dans V. Dans le chapitre suivant, nous explorerons la propriété et la gestion de la mémoire.
