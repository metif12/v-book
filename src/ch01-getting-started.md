# Chapter 1: Getting Started

Let's start your V journey! There's a lot to learn, but every journey starts with a small step. In this chapter, you'll learn how to:

- Install V on your system
- Write a "Hello, World!" program
- Use the V compiler and its commands
- Create a V project

## Installation

V can be installed on Windows, macOS, and Linux. The easiest way is to use the installer script:

### Windows

Download and run the installer from [vlang.io](https://vlang.io), or use PowerShell:

```powershell
irm https://raw.githubusercontent.com/vlang/v/master/installer.ps1 | iex
```

### macOS

```bash
brew install vlang
```

Or use the installer script:

```bash
curl -sSL https://raw.githubusercontent.com/vlang/v/master/installer.sh | bash
```

### Linux

```bash
curl -sSL https://raw.githubusercontent.com/vlang/v/master/installer.sh | bash
```

### From source

To build V from source:

```bash
git clone https://github.com/vlang/v
cd v
make
```

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
| `v fmt file.v` | Format a V file |
| `v test .` | Run tests in the current directory |
| `v doc .` | Generate documentation |
| `v doctor` | Diagnose your V installation |

## Summary

In this chapter, you learned how to install V, write a "Hello, World!" program, and use the V compiler. In the next chapter, we'll look at how to structure a V project.
