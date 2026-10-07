# اصلاح‌کننده‌های دسترسی

فیلدها به صورت پیش‌فرض خصوصی هستند:

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

## قابلیت مشاهده

| اصلاح‌کننده | محدوده |
|----------|-------|
| (هیچ) | فقط ماژول |
| `pub` | عمومی |

## بعدی

[فصل ۶: enum ها و انواع جمع](ch06-enums-and-sum-types.md)
