# 模块系统

```
my_project/
├── v.mod
├── main.v
└── math/
    └── math.v
```

`math/math.v`：

```v ignore
module math

pub fn add(a int, b int) int {
    return a + b
}
```

`main.v`：

```v ignore
import math

fn main() {
    println(math.add(2, 3))
}
```

## 下一步

[可见性](ch07-02-visibility.md)
