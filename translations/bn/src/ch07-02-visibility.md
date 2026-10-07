# ভিজিবিলিটি

- `pub` — পাবলিক, অন্য module থেকে অ্যাক্সেসযোগ্য
- (কোনো মডিফায়ার নেই) — প্রাইভেট, শুধুমাত্র module

```v ignore
module math

fn private_helper() int {
    return 42
}

pub fn public_function() int {
    return private_helper()
}
```

## পরবর্তী

[VPM](ch07-03-vpm.md)
