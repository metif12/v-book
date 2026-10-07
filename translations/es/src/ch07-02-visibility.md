# Visibilidad

- `pub` — público, accesible desde otros módulos
- (sin modificador) — privado, solo módulo

```v ignore
module math

fn private_helper() int {
    return 42
}

pub fn public_function() int {
    return private_helper()
}
```

## Siguiente

[VPM](ch07-03-vpm.md)
