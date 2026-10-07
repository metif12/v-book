# Chapter 11: Testing

V has a built-in testing framework.

## Test files

Create a file ending in `_test.v`:

```v
fn add(a int, b int) int {
    return a + b
}

fn test_add() {
    assert add(2, 3) == 5
    assert add(-1, 1) == 0
}
```

## Running tests

```bash
v test .
```

## Test organization

```v
fn add(a int, b int) int {
    return a + b
}

fn sub(a int, b int) int {
    return a - b
}

fn mul(a int, b int) int {
    return a * b
}

fn test_add() {
    assert add(2, 3) == 5
}

fn test_sub() {
    assert sub(5, 3) == 2
}

fn test_mul() {
    assert mul(2, 3) == 6
}
```

## Table-driven tests

```v
fn add(a int, b int) int {
    return a + b
}

fn test_add() {
    tests := [
        [2, 3, 5],
        [-1, 1, 0],
        [0, 0, 0],
    ]
    for t in tests {
        assert add(t[0], t[1]) == t[2]
    }
}
```

## Summary

In this chapter, you learned about V's testing framework. In the next chapter, we'll build a command-line tool.
