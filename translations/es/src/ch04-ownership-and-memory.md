# Capítulo 4: Propiedad y Memoria

V adopta un enfoque diferente a la gestión de memoria que muchos lenguajes. En lugar de la gestión manual de memoria o la recolección de basura por sí sola, V ofrece múltiples estrategias.

## Stack y Heap

V decide automáticamente si asignar en el stack o en el heap:

```v
fn main() {
    // Stack-allocated (small, fixed size)
    x := 42
    arr := [1, 2, 3]

    // Heap-allocated (large, dynamic)
    mut big := []int{}
    for i in 0 .. 1000 {
        big << i
    }

    println('${x} ${arr} ${big.len}')
}
```

## Recolección de Basura

V usa un recolector de basura por defecto. No necesitas liberar memoria manualmente:

```v
fn main() {
    mut names := []string{}
    for i in 0 .. 100 {
        names << 'name ${i}'
    }
    // Memory is automatically freed when no longer referenced
    println(names.len)
}
```

## Autofree

V tiene un modo autofree que libera memoria automáticamente cuando las variables salen de ámbito:

```bash
v -autofree main.v
```

```v
fn process() {
    mut data := []int{}
    for i in 0 .. 1000 {
        data << i
    }
    // data is automatically freed here
}

fn main() {
    process()
    println('done')
}
```

## Referencias

Puedes usar referencias para evitar copiar datos grandes:

```v
fn modify(mut arr []int) {
    arr << 42
}

fn main() {
    mut data := [1, 2, 3]
    modify(mut data)
    println(data)
}
```

## Modos de gestión de memoria

| Modo | Opción | Descripción |
|------|--------|-------------|
| GC (por defecto) | `-gc boehm` | Recolector de basura Boehm |
| Autofree | `-autofree` | Liberación automática de memoria |
| Ninguno | `-gc none` | Gestión manual de memoria |
| Prealloc | `-prealloc` | Asignación en arena |

## Resumen

En este capítulo, aprendiste sobre las opciones de gestión de memoria de V. En el siguiente capítulo, exploraremos los structs.
