# Capítulo 18: Gestión de Memoria en Profundidad

## Modos de GC

V proporciona varias estrategias de gestión de memoria, cada una adaptada a diferentes casos de uso.

| Modo | Opción | Caso de uso |
|------|--------|-------------|
| Boehm GC | `-gc boehm` | Uso general |
| Autofree | `-autofree` | Liberación automática |
| Ninguno | `-gc none` | Gestión manual |
| Prealloc | `-prealloc` | Asignación en arena |

## Stack vs heap

V decide automáticamente dónde asignar memoria. Los valores pequeños y de corta vida permanecen en el stack. Los valores más grandes o que escapan van al heap.

```v
fn stack_example() int {
    x := 42
    y := x * 2
    return y
}

fn heap_example() []int {
    data := []int{len: 100, init: 0}
    return data
}

fn main() {
    a := stack_example()
    b := heap_example()
    println(a)
    println(b.len)
}
```

## Modo autofree

Autofree libera memoria automáticamente cuando las variables salen de ámbito. Usa conteo de referencias para las asignaciones en el heap.

```v
fn create_user(name string) string {
    greeting := 'Hello, ${name}!'
    return greeting
}

fn main() {
    msg := create_user('World')
    println(msg)
}
```

## -gc none y memoria manual

Con `-gc none`, V desactiva la recolección de basura. Debes gestionar la memoria manualmente usando `free`.

```v
fn main() {
    mut data := []int{len: 1000, init: 0}
    for i in 0 .. 1000 {
        data[i] = i * 2
    }
    println(data[500])
    unsafe {
        data.free()
    }
}
```

## Asignación en arena con -prealloc

Prealloc usa asignación en arena para mejor rendimiento en bucles ajustados. Las asignaciones se liberan en bloque.

```v
fn process_items(count int) int {
    mut total := 0
    $if prealloc {
        for i in 0 .. count {
            total += i * i
        }
    } $else {
        for i in 0 .. count {
            total += i * i
        }
    }
    return total
}

fn main() {
    result := process_items(10000)
    println(result)
}
```

## Código inseguro

El bloque `unsafe` permite operaciones que omiten las garantías de seguridad de V, como aritmética de punteros y acceso directo a memoria.

```v
fn main() {
    x := 42
    p := unsafe { &x }
    println(p)
    unsafe {
        q := p + 1
        println(q)
    }
}
```

### Aritmética de punteros

```v
fn main() {
    arr := [10, 20, 30, 40, 50]
    unsafe {
        p := &arr[0]
        first := p[0]
        second := p[1]
        third := p[2]
        println('${first} ${second} ${third}')
    }
}
```

## Ajuste de rendimiento

Elegir el modo de gestión de memoria correcto puede impactar significativamente el rendimiento.

### Benchmarking de diferentes modos

```v
fn benchmark_allocations(iterations int) i64 {
    sw := i64(0)
    $if boehm ? {
        sw = i64(1)
    }
    $if autofree ? {
        sw = i64(2)
    }
    $if prealloc ? {
        sw = i64(3)
    }
    return sw
}

fn main() {
    mode := benchmark_allocations(1000000)
    println('Mode: ${mode}')
}
```

### Optimización de estructuras de datos

```v
struct Point {
    x f64
    y f64
}

fn sum_points(points []Point) f64 {
    mut total := 0.0
    for p in points {
        total += p.x + p.y
    }
    return total
}

fn main() {
    points := []Point{len: 10000, init: Point{x: 1.0, y: 2.0}}
    result := sum_points(points)
    println(result)
}
```

## Resumen

En este capítulo, aprendiste sobre los modos de gestión de memoria, asignación stack vs heap, autofree, gestión manual de memoria, prealloc, código inseguro y ajuste de rendimiento. En el siguiente capítulo, exploraremos las herramientas.
