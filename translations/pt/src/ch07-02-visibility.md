# Visibilidade

- `pub` — público, acessível de outros módulos
- (sem modificador) — privado, apenas módulo

```v ignore
module math

fn private_helper() int {
    return 42
}

pub fn public_function() int {
    return private_helper()
}
```

## Próximo

[VPM](ch07-03-vpm.md)
