# Stack and Heap

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

## Stack

- Fast allocation and deallocation
- Fixed size at compile time
- Automatically freed when scope ends

## Heap

- Dynamic size
- Slower allocation
- Managed by GC or autofree

## Next

[Garbage Collection](ch04-02-garbage-collection.md)
