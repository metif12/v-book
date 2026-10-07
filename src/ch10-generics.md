# Chapter 10: Generics

Generics allow you to write code that works with any type.

## Generic functions

```v
fn max[T](a T, b T) T {
    return if a > b { a } else { b }
}

fn main() {
    println(max(3, 7))
    println(max(3.14, 2.71))
}
```

## Generic structs

```v
struct Stack[T] {
mut:
    items []T
}

fn (mut s Stack[T]) push(item T) {
    s.items << item
}

fn (mut s Stack[T]) pop() ?T {
    if s.items.len == 0 {
        return none
    }
    return s.items.pop()
}

fn main() {
    mut s := Stack[int]{}
    s.push(1)
    s.push(2)
    println(s.pop())
}
```

## Type constraints

```v
fn sum[T](items []T) T {
    mut total := T(0)
    for item in items {
        total += item
    }
    return total
}

fn main() {
    println(sum([1, 2, 3]))
    println(sum([1.0, 2.0, 3.0]))
}
```

## Summary

In this chapter, you learned about generic functions and structs. In the next chapter, we'll explore testing.
