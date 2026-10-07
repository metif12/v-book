# Modifier Akses

Field bersifat private secara default:

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

## Visibilitas

| Modifier | Scope |
|----------|-------|
| (none) | Module only |
| `pub` | Public |

## Berikutnya

[Bab 6: Enum dan Tipe Sum](ch06-enums-and-sum-types.md)
