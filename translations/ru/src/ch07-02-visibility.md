# Видимость

- `pub` — публичный, доступен из других модулей
- (без модификатора) — приватный, только для модуля

```v ignore
module math

fn private_helper() int {
    return 42
}

pub fn public_function() int {
    return private_helper()
}
```

## Далее

[VPM](ch07-03-vpm.md)
