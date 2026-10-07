# Bonjour, V !

Regardons un exemple plus intéressant :

```v
fn main() {
    name := 'V'
    println('Hello, ${name}!')
    println('${name} is a great language.')
}
```

Exécutez-le :

```bash
v run main.v
```

Sortie :

```
Hello, V!
V is a great language.
```

## Interpolation de chaînes

V utilise `${...}` pour l'interpolation de chaînes. Toute expression à l'intérieur de `${...}` est évaluée et convertie en chaîne :

```v
fn main() {
    a := 42
    b := 3.14
    println('a = ${a}, b = ${b}')
    println('a + 10 = ${a + 10}')
}
```

## Variables

Utilisez `:=` pour déclarer et initialiser une variable :

```v
fn main() {
    name := 'V'
    version := 0.5
    is_awesome := true
    println('${name} v${version} is awesome: ${is_awesome}')
}
```

## Suivant

[Chapitre 2 : Créer un projet](ch02-building-a-project.md)
