# Chapter 1: Getting Started

Let's start your V journey! There's a lot to learn, but every journey starts with a small step. In this chapter, you'll learn how to:

- Install V on your system
- Write a "Hello, World!" program
- Use the V compiler and its commands
- Create a V project

## Installation

V is built from source, which takes a few seconds and needs a working `git` and a C toolchain ([the full instructions are their own lesson](ch01-01-installation.md)):

```bash
git clone --depth=1 https://github.com/vlang/v
cd v
make
```

On Windows run `makev.bat` instead of `make`. Then put V on the PATH with `sudo ./v symlink` — or `v symlink` from an administrative shell on Windows — and restart your shell.

## Verifying the installation

After installation, verify V is working:

```bash
v version
```

You should see output like:

```
V 0.5.2
```

## Hello, World!

Now let's write our first V program. Create a file called `main.v`:

```v
fn main() {
    println('Hello, World!')
}
```

Run it:

```bash
v run main.v
```

You should see:

```
Hello, World!
```

Congratulations! You've written and run your first V program.

## Hello, V!

Let's look at a slightly more interesting example:

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

## The V compiler

The V compiler is invoked with the `v` command. Common commands:

| Command | Description |
|---------|-------------|
| `v run file.v` | Compile and run a V file |
| `v file.v` | Compile a V file to an executable |
| `v fmt -w file.v` | Format a V file in place |
| `v test .` | Run the `_test.v` files of a directory |
| `v doc strings` | Generate the documentation of a module |
| `v doctor` | Print system details for a bug report |
| `v up` | Update V to the latest version |

## Summary

In this chapter, you learned how to install V, write a "Hello, World!" program, and use the V compiler. In the next chapter, we'll look at how to structure a V project.
