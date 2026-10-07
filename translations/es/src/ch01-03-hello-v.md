# ¡Hola, V!

Veamos un ejemplo más interesante:

```v
fn main() {
    name := 'V'
    println('Hello, ${name}!')
    println('${name} is a great language.')
}
```

Ejecútalo:

```bash
v run main.v
```

Salida:

```
Hello, V!
V is a great language.
```

## Interpolación de strings

V usa `${...}` para la interpolación de strings. Cualquier expresión dentro de `${...}` se evalúa y se convierte a string:

```v
fn main() {
    a := 42
    b := 3.14
    println('a = ${a}, b = ${b}')
    println('a + 10 = ${a + 10}')
}
```

## Variables

Usa `:=` para declarar e inicializar una variable:

```v
fn main() {
    name := 'V'
    version := 0.5
    is_awesome := true
    println('${name} v${version} is awesome: ${is_awesome}')
}
```

## Siguiente

[Capítulo 2: Construyendo un Proyecto](ch02-building-a-project.md)
