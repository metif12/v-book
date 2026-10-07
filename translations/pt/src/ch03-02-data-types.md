# Tipos de Dados

## Tipos inteiros

| Tipo | Tamanho | Intervalo |
|------|------|-------|
| `i8` | 8 bits | -128 a 127 |
| `i16` | 16 bits | -32.768 a 32.767 |
| `i32` | 32 bits | -2^31 a 2^31-1 |
| `i64` | 64 bits | -2^63 a 2^63-1 |
| `int` | plataforma | geralmente 64 bits |
| `u8` | 8 bits | 0 a 255 |
| `u16` | 16 bits | 0 a 65.535 |
| `u32` | 32 bits | 0 a 2^32-1 |
| `u64` | 64 bits | 0 a 2^64-1 |

## Tipos float

| Tipo | Tamanho |
|------|------|
| `f32` | 32 bits |
| `f64` | 64 bits |

## Outros tipos

- `bool` — `true` ou `false`
- `string` — string UTF-8
- `rune` — caractere Unicode único (alias para `u32`)
- `byte` — alias para `u8`

## Conversão de tipo

```v
fn main() {
    a := 42
    b := f64(a)
    c := int(b)
    println('${a} ${b} ${c}')
}
```

## Próximo

[Funções](ch03-03-functions.md)
