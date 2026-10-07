# Modificateurs d'accès

Les champs sont privés par défaut :

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

## Visibilité

| Modificateur | Portée |
|--------------|--------|
| (aucun) | Module uniquement |
| `pub` | Public |

## Suivant

[Chapitre 6 : Enums et types somme](ch06-enums-and-sum-types.md)
