# Hello, V!

Let's look at a more interesting example:

```v
fn main() {
    name := 'V'
    println('Hello, ${name}!')
    println('${name} is a great language.')
}
```

Run it:

```bash
v run main.v
```

Output:

```
Hello, V!
V is a great language.
```

## String interpolation

V uses `${...}` for string interpolation. Any expression inside `${...}` is evaluated and converted to a string:

```v
fn main() {
    a := 42
    b := 3.14
    println('a = ${a}, b = ${b}')
    println('a + 10 = ${a + 10}')
}
```

## Variables

Use `:=` to declare and initialize a variable:

```v
fn main() {
    name := 'V'
    version := 0.5
    is_awesome := true
    println('${name} v${version} is awesome: ${is_awesome}')
}
```

## Next

[Chapter 2: Building a Project](ch02-building-a-project.md)
