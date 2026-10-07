# অধ্যায় 10: জেনেরিক্স

জেনেরিক্স আপনাকে যেকোনো টাইপের সাথে কাজ করা কোড লিখতে দেয়।

## জেনেরিক ফাংশন

```v
fn max[T](a T, b T) T {
    return if a > b { a } else { b }
}

fn main() {
    println(max(3, 7))
    println(max(3.14, 2.71))
}
```

## জেনেরিক struct

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

## টাইপ সীমাবদ্ধতা

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

## সারসংক্ষেপ

এই অধ্যায়ে আপনি জেনেরিক ফাংশন এবং struct সম্পর্কে শিখেছেন। পরবর্তী অধ্যায়ে আমরা টেস্টিং শিখব।
