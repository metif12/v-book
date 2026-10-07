# অটোফ্রি

V-তে একটি অটোফ্রি মোড আছে যা স্বয়ংক্রিয়ভাবে মেমোরি ফ্রি করে:

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

## পরবর্তী

[রেফারেন্স](ch04-04-references.md)
