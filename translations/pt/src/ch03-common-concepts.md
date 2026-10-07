# Capítulo 3: Conceitos Comuns

Este capítulo cobre os conceitos comuns de programação em V: variáveis, tipos de dados, funções, comentários e fluxo de controle.

## Variáveis e Mutabilidade

Em V, variáveis são imutáveis por padrão. Use `mut` para torná-las mutáveis:

```v
fn main() {
    name := 'V'
    // name = 'Go'  // Erro: name é imutável

    mut count := 0
    count = 1  // OK: count é mutável
    count++
    println(count)
}
```

## Tipos de Dados

V tem um sistema de tipos rico:

```v
fn main() {
    // Inteiros
    a := 42        // int
    b := i64(100)  // inteiro de 64 bits
    c := u8(255)   // sem sinal de 8 bits

    // Floats
    pi := 3.14     // f64
    e := f32(2.71) // float de 32 bits

    // Outros tipos
    name := 'V'    // string
    is_ok := true  // bool
    letter := `A`  // rune (caractere único)

    println('${a} ${b} ${c}')
    println('${pi} ${e}')
    println('${name} ${is_ok} ${letter}')
}
```

## Funções

Funções são declaradas com `fn`:

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

## Comentários

```v
// This is a line comment

/* This is a
   block comment */
```

## Fluxo de Controle

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

### Loop For

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

## Resumo

Neste capítulo, você aprendeu sobre variáveis, tipos de dados, funções, comentários e fluxo de controle em V. No próximo capítulo, vamos explorar posse e gerenciamento de memória.
