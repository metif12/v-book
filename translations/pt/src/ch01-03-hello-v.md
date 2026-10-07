# Olá, V!

Vamos ver um exemplo mais interessante:

```v
fn main() {
    name := 'V'
    println('Hello, ${name}!')
    println('${name} is a great language.')
}
```

Execute:

```bash
v run main.v
```

Saída:

```
Hello, V!
V is a great language.
```

## Interpolação de strings

V usa `${...}` para interpolação de strings. Qualquer expressão dentro de `${...}` é avaliada e convertida para string:

```v
fn main() {
    a := 42
    b := 3.14
    println('a = ${a}, b = ${b}')
    println('a + 10 = ${a + 10}')
}
```

## Variáveis

Use `:=` para declarar e inicializar uma variável:

```v
fn main() {
    name := 'V'
    version := 0.5
    is_awesome := true
    println('${name} v${version} is awesome: ${is_awesome}')
}
```

## Próximo

[Capítulo 2: Construindo um Projeto](ch02-building-a-project.md)
