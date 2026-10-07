# অ্যাক্সেস মডিফায়ার

ফিল্ডগুলো ডিফল্টভাবে প্রাইভেট:

```v
struct User {
    name string
pub:
    age int
}

fn main() {
    u := User{name: 'Alice', age: 30}
    println(u.name)  // OK: same module
    println(u.age)   // OK: public
}
```

## ভিজিবিলিটি

| মডিফায়ার | স্কোপ |
|----------|-------|
| (কোনোটি নেই) | শুধুমাত্র module |
| `pub` | পাবলিক |

## পরবর্তী

[অধ্যায় 6: enum এবং sum type](ch06-enums-and-sum-types.md)
