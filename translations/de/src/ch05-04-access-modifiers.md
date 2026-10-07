# Zugriffsmodifikatoren

Felder sind standardmäßig privat:

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

## Sichtbarkeit

| Modifikator | Gültigkeitsbereich |
|----------|-------|
| (keiner) | Nur Modul |
| `pub` | Öffentlich |

## Weiter

[Kapitel 6: Enums und Sum Types](ch06-enums-and-sum-types.md)
