# 可见性

- `pub` — 公开，可从其他模块访问
- （无修饰符）— 私有，仅模块内

```v ignore
module math

fn private_helper() int {
    return 42
}

pub fn public_function() int {
    return private_helper()
}
```

## 下一步

[VPM](ch07-03-vpm.md)
