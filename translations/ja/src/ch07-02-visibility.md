# 可視性

- `pub` — パブリック、他のモジュールからアクセス可能
- （修飾子なし） — プライベート、モジュール内のみ

```v ignore
module math

fn private_helper() int {
    return 42
}

pub fn public_function() int {
    return private_helper()
}
```

## 次へ

[VPM](ch07-03-vpm.md)
