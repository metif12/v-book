# Access Modifiers

Fields are private by default:

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

## Visibility

| Modifier | Scope |
|----------|-------|
| (none) | Module only |
| `pub` | Public |

## Next

[Chapter 6: Enums and Sum Types](ch06-enums-and-sum-types.md)
