# آزادسازی خودکار

V یک حالت آزادسازی خودکار دارد که به صورت خودکار حافظه را آزاد می‌کند:

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

## بعدی

[مراجع](ch04-04-references.md)
