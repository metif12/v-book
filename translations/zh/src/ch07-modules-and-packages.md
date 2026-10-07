# 第 7 章：模块与包

## 模块系统

V 将代码组织为模块。模块是包含 `.v` 文件的目录：

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

## 可见性

- `pub` — 公开，可从其他模块访问
- （无修饰符）— 私有，仅模块内

## VPM

V 包管理器（VPM）托管社区包：

```bash
v install vsl
```

## 小结

在本章中，你学习了模块、可见性和 VPM。在下一章中，我们将探讨集合。
