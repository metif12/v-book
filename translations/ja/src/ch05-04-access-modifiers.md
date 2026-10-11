# アクセス修飾子

フィールドはデフォルトでプライベートです：

```v
struct User {
    name string
pub:
    age int
}

fn main() {
    u := User{name: 'Alice', age: 30}
    println(u.name)  // OK: same module
    println(u.age)   // OK: public
}
```
## 可視性

| 修飾子 | スコープ |
|----------|-------|
| （なし） | モジュール内のみ |
| `pub` | パブリック |

## 次へ

[第6章：enumとsum型](ch06-enums-and-sum-types.md)
