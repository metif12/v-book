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
    println(u.name)  // OK: same module
    println(u.age)   // OK: public
}
```
## Visibilità

| Modificatore | Scope |
|--------------|-------|
| (nessuno) | Solo modulo |
| `pub` | Pubblico |

## Avanti

[Capitolo 6: Enum e Tipi Sum](ch06-enums-and-sum-types.md)
