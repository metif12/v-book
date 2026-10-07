# Hallo, V!

Betrachten wir ein interessanteres Beispiel:

```v
fn main() {
    name := 'V'
    println('Hello, ${name}!')
    println('${name} is a great language.')
}
```

Führen Sie es aus:

```bash
v run main.v
```

Ausgabe:

```
Hello, V!
V is a great language.
```

## String-Interpolation

V verwendet `${...}` für die String-Interpolation. Jeder Ausdruck innerhalb von `${...}` wird ausgewertet und in einen String umgewandelt:

```v
fn main() {
    a := 42
    b := 3.14
    println('a = ${a}, b = ${b}')
    println('a + 10 = ${a + 10}')
}
```

## Variablen

Verwenden Sie `:=`, um eine Variable zu deklarieren und zu initialisieren:

```v
fn main() {
    name := 'V'
    version := 0.5
    is_awesome := true
    println('${name} v${version} is awesome: ${is_awesome}')
}
```

## Weiter

[Kapitel 2: Ein Projekt aufbauen](ch02-building-a-project.md)
