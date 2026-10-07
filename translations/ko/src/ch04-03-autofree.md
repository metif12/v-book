# Autofree

V에는 메모리를 자동으로 해제하는 autofree 모드가 있습니다:

```bash
v -autofree main.v
```

```v
fn process() {
    mut data := []int{}
    for i in 0 .. 1000 {
        data << i
    }
    // data는 여기서 자동으로 해제됩니다
}

fn main() {
    process()
    println('done')
}
```

## 다음

[참조](ch04-04-references.md)
