# Автоосвобождение

В V есть режим автоосвобождения, который автоматически освобождает память:

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

## Далее

[Ссылки](ch04-04-references.md)
