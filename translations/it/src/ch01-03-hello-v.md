# Ciao, V!

Vediamo un esempio più interessante:

```v
fn main() {
    name := 'V'
    println('Hello, ${name}!')
    println('${name} is a great language.')
}
```

Eseguilo:

```bash
v run main.v
```

Output:

```
Hello, V!
V is a great language.
```

## Interpolazione delle stringhe

V usa `${...}` per l'interpolazione delle stringhe. Qualsiasi espressione dentro `${...}` viene valutata e convertita in stringa:

```v
fn main() {
    a := 42
    b := 3.14
    println('a = ${a}, b = ${b}')
    println('a + 10 = ${a + 10}')
}
```

## Variabili

Usa `:=` per dichiarare e inizializzare una variabile:

```v
fn main() {
    name := 'V'
    version := 0.5
    is_awesome := true
    println('${name} v${version} is awesome: ${is_awesome}')
}
```

## Avanti

[Capitolo 2: Costruire un Progetto](ch02-building-a-project.md)
