# Types de données

## Types entiers

| Type | Taille | Plage |
|------|--------|-------|
| `i8` | 8 bits | -128 à 127 |
| `i16` | 16 bits | -32 768 à 32 767 |
| `i32` | 32 bits | -2^31 à 2^31-1 |
| `i64` | 64 bits | -2^63 à 2^63-1 |
| `int` | plateforme | généralement 64 bits |
| `u8` | 8 bits | 0 à 255 |
| `u16` | 16 bits | 0 à 65 535 |
| `u32` | 32 bits | 0 à 2^32-1 |
| `u64` | 64 bits | 0 à 2^64-1 |

## Types flottants

| Type | Taille |
|------|--------|
| `f32` | 32 bits |
| `f64` | 64 bits |

## Autres types

- `bool` — `true` ou `false`
- `string` — chaîne UTF-8
- `rune` — caractère Unicode unique (alias de `u32`)
- `byte` — alias de `u8`

## Conversion de type

```v
fn main() {
    a := 42
    b := f64(a)
    c := int(b)
    println('${a} ${b} ${c}')
}
```

## Suivant

[Fonctions](ch03-03-functions.md)
