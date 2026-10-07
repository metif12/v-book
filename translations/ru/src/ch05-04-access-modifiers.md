# Модификаторы доступа

Поля по умолчанию приватные:

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

## Видимость

| Модификатор | Область видимости |
|-------------|-------------------|
| (нет) | Только модуль |
| `pub` | Публичный |

## Далее

[Глава 6: Перечисления и суммирующие типы](ch06-enums-and-sum-types.md)
