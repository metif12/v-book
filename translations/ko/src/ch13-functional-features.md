# Chapter 13: Functional Features

V supports closures and higher-order functions.

## Closures

```v
fn main() {
    add := fn (a int, b int) int {
        return a + b
    }
    println(add(2, 3))
}
```

## Higher-order functions

```v
fn apply(f fn (int) int, x int) int {
    return f(x)
}

fn main() {
    double := fn (x int) int {
        return x * 2
    }
    println(apply(double, 5))
}
```

## Anonymous functions

```v
fn main() {
    nums := [1, 2, 3, 4, 5]
    doubled := nums.map(fn (x int) int {
        return x * 2
    })
    println(doubled)
}
```

## Summary

In this chapter, you learned about closures and higher-order functions. In the next chapter, we'll explore concurrency.
