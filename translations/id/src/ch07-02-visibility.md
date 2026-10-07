# Visibilitas

- `pub` — public, dapat diakses dari modul lain
- (tanpa modifier) — private, hanya modul tersebut

```v ignore
module math

fn private_helper() int {
    return 42
}

pub fn public_function() int {
    return private_helper()
}
```

## Berikutnya

[VPM](ch07-03-vpm.md)
