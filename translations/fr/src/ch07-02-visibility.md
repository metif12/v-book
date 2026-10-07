# Visibilité

- `pub` — public, accessible depuis d'autres modules
- (aucun modificateur) — privé, module uniquement

```v ignore
module math

fn private_helper() int {
    return 42
}

pub fn public_function() int {
    return private_helper()
}
```

## Suivant

[VPM](ch07-03-vpm.md)
