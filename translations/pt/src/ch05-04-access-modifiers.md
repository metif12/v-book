# Modificadores de Acesso

Campos são privados por padrão:

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

## Visibilidade

| Modificador | Escopo |
|----------|-------|
| (nenhum) | Apenas módulo |
| `pub` | Público |

## Próximo

[Capítulo 6: Enums e Tipos Soma](ch06-enums-and-sum-types.md)
