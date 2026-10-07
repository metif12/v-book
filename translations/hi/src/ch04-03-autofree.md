# ऑटोफ्री

V में एक ऑटोफ्री मोड है जो स्वचालित रूप से मेमोरी फ्री करता है:

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

## अगला

[रेफरेंस](ch04-04-references.md)
