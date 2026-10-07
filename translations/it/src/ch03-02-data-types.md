# Tipi di Dato

## Tipi interi

| Tipo | Dimensione | Intervallo |
|------|-----------|------------|
| `i8` | 8-bit | -128 a 127 |
| `i16` | 16-bit | -32.768 a 32.767 |
| `i32` | 32-bit | -2^31 a 2^31-1 |
| `i64` | 64-bit | -2^63 a 2^63-1 |
| `int` | piattaforma | di solito 64-bit |
| `u8` | 8-bit | 0 a 255 |
| `u16` | 16-bit | 0 a 65.535 |
| `u32` | 32-bit | 0 a 2^32-1 |
| `u64` | 64-bit | 0 a 2^64-1 |

## Tipi float

| Tipo | Dimensione |
|------|-----------|
| `f32` | 32-bit |
| `f64` | 64-bit |

## Altri tipi

- `bool` — `true` o `false`
- `string` — stringa UTF-8
- `rune` — carattere Unicode singolo (alias per `u32`)
- `byte` — alias per `u8`

## Conversione di tipo

```v
fn main() {
    a := 42
    b := f64(a)
    c := int(b)
    println('${a} ${b} ${c}')
}
```

## Avanti

[Funzioni](ch03-03-functions.md)
