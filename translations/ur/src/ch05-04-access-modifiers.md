# رسائی کی تعدیل کار

فیلڈز ڈیفالٹ طور پر نجی ہوتے ہیں:

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

## مرئیت

| تعدیل کار | دائرہ کار |
|----------|-------|
| (کوئی نہیں) | صرف ماڈیول |
| `pub` | عوامی |

## اگلا

[باب ۶: enums اور سم ٹائپس](ch06-enums-and-sum-types.md)
