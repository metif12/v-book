# Chapter 4: Ownership and Memory

V takes a different approach to memory management than many languages. Instead of manual memory management or garbage collection alone, V offers multiple strategies.

## Stack and Heap

V automatically decides whether to allocate on the stack or heap:

```v
fn main() {
    // Stack-allocated (small, fixed size)
    x := 42
    arr := [1, 2, 3]

    // Heap-allocated (large, dynamic)
    mut big := []int{}
    for i in 0 .. 1000 {
        big << i
    }

    println('${x} ${arr} ${big.len}')
}
```

## Garbage Collection

V uses a garbage collector by default. You don't need to free memory manually:

```v
fn main() {
    mut names := []string{}
    for i in 0 .. 100 {
        names << 'name ${i}'
    }
    // Memory is automatically freed when no longer referenced
    println(names.len)
}
```

## Autofree

V has an autofree mode that automatically frees memory when variables go out of scope:

```bash
v -autofree main.v
```

```v
fn process() {
    mut data := []int{}
    for i in 0 .. 1000 {
        data << i
    }
    // data is automatically freed here
}

fn main() {
    process()
    println('done')
}
```

## References

You can use references to avoid copying large data:

```v
fn modify(mut arr []int) {
    arr << 42
}

fn main() {
    mut data := [1, 2, 3]
    modify(mut data)
    println(data)
}
```

## Memory management modes

| Mode | Flag | Description |
|------|------|-------------|
| GC (default) | `-gc boehm` | Boehm garbage collector |
| Autofree | `-autofree` | Automatic memory freeing |
| None | `-gc none` | Manual memory management |
| Prealloc | `-prealloc` | Arena allocation |

## Summary

In this chapter, you learned about V's memory management options. In the next chapter, we'll explore structs.
