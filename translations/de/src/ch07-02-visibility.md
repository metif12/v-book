# Sichtbarkeit

- `pub` — öffentlich, von anderen Modulen zugreifbar
- (kein Modifikator) — privat, nur innerhalb des Moduls

```v ignore
module math

fn private_helper() int {
    return 42
}

pub fn public_function() int {
    return private_helper()
}
```

## Weiter

[VPM](ch07-03-vpm.md)
