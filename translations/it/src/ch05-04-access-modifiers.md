# Modificatori di Accesso

I campi sono privati per impostazione predefinita:

```v
struct User {
    name string
pub:
    age int
}

fn main() {
    u := User{name: 'Alice', age: 30}
    println(u.name)  // OK: stesso modulo
    println(u.age)   // OK: pubblico
}
```

## Visibilità

| Modificatore | Scope |
|--------------|-------|
| (nessuno) | Solo modulo |
| `pub` | Pubblico |

## Avanti

[Capitolo 6: Enum e Tipi Sum](ch06-enums-and-sum-types.md)
