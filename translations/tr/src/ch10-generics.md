# Bölüm 10: Generics

Generics, herhangi bir tip ile çalışan kod yazmanızı sağlar.

## Generic fonksiyonlar

```v
fn max[T](a T, b T) T {
    return if a > b { a } else { b }
}

fn main() {
    println(max(3, 7))
    println(max(3.14, 2.71))
}
```

## Generic struct'lar

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

## Tip kısıtlamaları

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

## Özet

Bu bölümde generic fonksiyonlar ve struct'lar hakkında bilgi edindiniz. Sonraki bölümde test etmeyi inceleyeceğiz.
