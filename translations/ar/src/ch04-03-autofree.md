# التحرير التلقائي

لديه V وضع التحرير التلقائي الذي يحرر الذاكرة تلقائياً:

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

## التالي

[المراجع](ch04-04-references.md)
