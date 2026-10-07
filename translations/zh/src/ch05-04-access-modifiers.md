# 访问修饰符

字段默认是私有的：

```v
struct User {
    name string
pub:
    age int
}

fn main() {
    u := User{name: 'Alice', age: 30}
    println(u.name)  // 正确：同一模块
    println(u.age)   // 正确：公开
}
```

## 可见性

| 修饰符 | 作用域 |
|----------|-------|
| （无） | 仅模块内 |
| `pub` | 公开 |

## 下一步

[第 6 章：枚举与和类型](ch06-enums-and-sum-types.md)
