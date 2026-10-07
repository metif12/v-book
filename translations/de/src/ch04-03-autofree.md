# Autofree

V verfügt über einen Autofree-Modus, der Speicher automatisch freigibt:

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

## Weiter

[Referenzen](ch04-04-references.md)
