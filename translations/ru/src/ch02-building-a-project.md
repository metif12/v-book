# Chapter 2: Building a Project

In this chapter, you'll learn how to structure a V project, use `v.mod`, format code with `v fmt`, and write tests with `v test`.

## Project structure

A V project is a directory with a `v.mod` file and one or more `.v` files:

```
my_project/
├── v.mod
├── main.v
└── my_module.v
```

## v.mod

Every V project has a `v.mod` file that describes the project:

```v ignore
Module {
    name: 'my_project'
    description: 'My first V project'
    version: '0.1.0'
    license: 'MIT'
    dependencies: []
}
```

Create a new project with:

```bash
v init
```

This creates a `v.mod` and a `main.v` with a basic template.

## Formatting with v fmt

V has a built-in code formatter. Run it on your project:

```bash
v fmt -w .
```

The `-w` flag writes the formatted code back to the files.

## Testing with v test

V has a built-in testing framework. Create a file ending in `_test.v`:

```v
fn add(a int, b int) int {
    return a + b
}

fn test_add() {
    assert add(2, 3) == 5
    assert add(-1, 1) == 0
}
```

Run tests:

```bash
v test .
```

## Summary

In this chapter, you learned how to structure a V project, use `v.mod`, format code, and write tests. In the next chapter, we'll dive into the common programming concepts in V.
