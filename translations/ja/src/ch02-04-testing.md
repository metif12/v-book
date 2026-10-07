# Testing with v test

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

## Test functions

Test functions start with `test_` and take no arguments:

```v
fn test_something() {
    assert true
}
```

## Assertions

Use `assert` to check conditions:

```v
fn test_math() {
    assert 1 + 1 == 2
    assert 2 * 3 == 6
}
```

## Next

[Chapter 3: Common Concepts](ch03-common-concepts.md)
