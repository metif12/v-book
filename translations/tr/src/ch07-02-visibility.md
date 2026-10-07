# Visibility

- `pub` — public, accessible from other modules
- (no modifier) — private, module-only

```v ignore
module math

fn private_helper() int {
    return 42
}

pub fn public_function() int {
    return private_helper()
}
```

## Next

[VPM](ch07-03-vpm.md)
