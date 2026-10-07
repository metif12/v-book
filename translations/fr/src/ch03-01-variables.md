# Variables et mutabilité

En V, les variables sont immuables par défaut :

```v
fn main() {
    name := 'V'
    // name = 'Go'  // Error: name is immutable

    mut count := 0
    count = 1  // OK: count is mutable
    count++
    println(count)
}
```

## Déclaration

Utilisez `:=` pour déclarer et initialiser :

```v
x := 42
name := 'V'
is_ready := true
```

## Inférence de type

V déduit les types à partir de l'initialiseur :

```v
a := 42      // int
b := 3.14    // f64
c := 'hello' // string
d := true    // bool
```

## Types explicites

Vous pouvez spécifier les types explicitement :

```v
a := i64(42)
b := f32(3.14)
c := u8(255)
```

## Suivant

[Types de données](ch03-02-data-types.md)
