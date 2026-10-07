# Görünürlük

- `pub` — herkese açık, diğer modüllerden erişilebilir
- (belirleyici yok) — özel, yalnızca modül içi

```v ignore
module math

fn private_helper() int {
    return 42
}

pub fn public_function() int {
    return private_helper()
}
```

## Sonraki

[VPM](ch07-03-vpm.md)
