# Capítulo 13: Características Funcionales

V soporta closures y funciones de orden superior.

## Closures

```v
fn main() {
    add := fn (a int, b int) int {
        return a + b
    }
    println(add(2, 3))
}
```

## Funciones de orden superior

```v
fn apply(f fn (int) int, x int) int {
    return f(x)
}

fn main() {
    double := fn (x int) int {
        return x * 2
    }
    println(apply(double, 5))
}
```

## Funciones anónimas

```v
fn main() {
    nums := [1, 2, 3, 4, 5]
    doubled := nums.map(fn (x int) int {
        return x * 2
    })
    println(doubled)
}
```

## Resumen

En este capítulo, aprendiste sobre closures y funciones de orden superior. En el siguiente capítulo, exploraremos la concurrencia.
