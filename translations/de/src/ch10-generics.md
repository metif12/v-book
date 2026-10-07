# Kapitel 10: Generics

Generics ermöglichen es Ihnen, Code zu schreiben, der mit jedem Typ funktioniert.

## Generische Funktionen

```v
fn max[T](a T, b T) T {
    return if a > b { a } else { b }
}

fn main() {
    println(max(3, 7))
    println(max(3.14, 2.71))
}
```

## Generische Structs

```v
struct Stack[T] {
    items []T
}

fn (mut s Stack[T]) push(item T) {
    s.items << item
}

fn (s Stack[T]) pop() ?T {
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

## Typbeschränkungen

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

## Zusammenfassung

In diesem Kapitel haben Sie generische Funktionen und Structs kennengelernt. Im nächsten Kapitel untersuchen wir Testen.
