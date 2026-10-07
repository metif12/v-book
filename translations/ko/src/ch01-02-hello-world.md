# Hello, World!

Create a file called `main.v`:

```v
fn main() {
    println('Hello, World!')
}
```

Run it:

```bash
v run main.v
```

Output:

```
Hello, World!
```

## Anatomy of a V program

Let's break down the program:

- `fn main()` — Every V program starts with a `main` function. The `fn` keyword declares a function.
- `println(...)` — A built-in function that prints a line to stdout.
- `'Hello, World!'` — A string literal. V uses single quotes for strings.

## Compiling vs running

`v run` compiles and runs in one step. You can also compile first:

```bash
v main.v
./main
```

## Next

[Hello, V!](ch01-03-hello-v.md)
