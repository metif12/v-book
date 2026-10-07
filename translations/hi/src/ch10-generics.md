# अध्याय 10: जेनरिक्स

जेनरिक्स आपको किसी भी टाइप के साथ काम करने वाला कोड लिखने की अनुमति देते हैं।

## जेनरिक फ़ंक्शन

```v
fn max[T](a T, b T) T {
    return if a > b { a } else { b }
}

fn main() {
    println(max(3, 7))
    println(max(3.14, 2.71))
}
```

## जेनरिक structs

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

## टाइप कंस्ट्रेंट्स

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

## सारांश

इस अध्याय में, आपने जेनरिक फ़ंक्शन और structs के बारे में सीखा। अगले अध्याय में, हम टेस्टिंग का पता लगाएंगे।
