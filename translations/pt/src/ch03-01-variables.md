# Variáveis e Mutabilidade

Em V, variáveis são imutáveis por padrão:

```v
fn main() {
    name := 'V'
    // name = 'Go'  // Erro: name é imutável

    mut count := 0
    count = 1  // OK: count é mutável
    count++
    println(count)
}
```

## Declaração

Use `:=` para declarar e inicializar:

```v
x := 42
name := 'V'
is_ready := true
```

## Inferência de tipo

V infere tipos a partir do inicializador:

```v
a := 42      // int
b := 3.14    // f64
c := 'hello' // string
d := true    // bool
```

## Tipos explícitos

Você pode especificar tipos explicitamente:

```v
a := i64(42)
b := f32(3.14)
c := u8(255)
```

## Próximo

[Tipos de Dados](ch03-02-data-types.md)
