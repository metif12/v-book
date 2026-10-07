# Variables y Mutabilidad

En V, las variables son inmutables por defecto:

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

## Declaración

Usa `:=` para declarar e inicializar:

```v
x := 42
name := 'V'
is_ready := true
```

## Inferencia de tipos

V infiere los tipos a partir del inicializador:

```v
a := 42      // int
b := 3.14    // f64
c := 'hello' // string
d := true    // bool
```

## Tipos explícitos

Puedes especificar tipos explícitamente:

```v
a := i64(42)
b := f32(3.14)
c := u8(255)
```

## Siguiente

[Tipos de Datos](ch03-02-data-types.md)
