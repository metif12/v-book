# آٹوفری

V میں ایک آٹوفری موڈ ہے جو خودکار طور پر میموری آزاد کرتا ہے:

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

## اگلا

[حوالہ جات](ch04-04-references.md)
