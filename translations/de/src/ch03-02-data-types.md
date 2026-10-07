# Datentypen

## Ganzzahltypen

| Typ | Größe | Bereich |
|------|------|-------|
| `i8` | 8-bit | -128 to 127 |
| `i16` | 16-bit | -32,768 to 32,767 |
| `i32` | 32-bit | -2^31 to 2^31-1 |
| `i64` | 64-bit | -2^63 to 2^63-1 |
| `int` | platform | usually 64-bit |
| `u8` | 8-bit | 0 to 255 |
| `u16` | 16-bit | 0 to 65,535 |
| `u32` | 32-bit | 0 to 2^32-1 |
| `u64` | 64-bit | 0 to 2^64-1 |

## Gleitkommatypen

| Typ | Größe |
|------|------|
| `f32` | 32-bit |
| `f64` | 64-bit |

## Andere Typen

- `bool` — `true` oder `false`
- `string` — UTF-8-String
- `rune` — einzelnes Unicode-Zeichen (Alias für `u32`)
- `byte` — Alias für `u8`

## Typumwandlung

```v
fn main() {
    a := 42
    b := f64(a)
    c := int(b)
    println('${a} ${b} ${c}')
}
```

## Weiter

[Funktionen](ch03-03-functions.md)
