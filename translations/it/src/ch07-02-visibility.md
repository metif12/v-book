# Visibilità

- `pub` — pubblico, accessibile da altri moduli
- (nessun modificatore) — privato, solo modulo

```v ignore
module math

fn private_helper() int {
    return 42
}

pub fn public_function() int {
    return private_helper()
}
```

## Avanti

[VPM](ch07-03-vpm.md)
