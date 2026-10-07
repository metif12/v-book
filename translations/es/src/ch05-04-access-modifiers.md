# Modificadores de Acceso

Los campos son privados por defecto:

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

## Visibilidad

| Modificador | Ámbito |
|-------------|--------|
| (ninguno) | Solo módulo |
| `pub` | Público |

## Siguiente

[Capítulo 6: Enums y Tipos Suma](ch06-enums-and-sum-types.md)
