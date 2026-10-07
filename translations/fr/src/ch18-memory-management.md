# Chapitre 18 : Approfondissement de la gestion mémoire

## Modes de GC

V fournit plusieurs stratégies de gestion de la mémoire, chacune adaptée à différents cas d'usage.

| Mode | Option | Cas d'usage |
|------|--------|-------------|
| Boehm GC | `-gc boehm` | Usage général |
| Autofree | `-autofree` | Libération automatique |
| Aucun | `-gc none` | Gestion manuelle |
| Prealloc | `-prealloc` | Allocation par arène |

## Pile vs tas

V décide automatiquement où allouer la mémoire. Les petites valeurs de courte durée restent sur la pile. Les valeurs plus grandes ou qui s'échappent vont sur le tas.

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

## Mode autofree

Autofree libère automatiquement la mémoire lorsque les variables sortent de leur portée. Il utilise le comptage de références pour les allocations du tas.

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

## -gc none et gestion manuelle de la mémoire

Avec `-gc none`, V désactive le ramasse-miettes. Vous devez gérer manuellement la mémoire en utilisant `free`.

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

## Allocation par arène -prealloc

Prealloc utilise l'allocation par arène pour de meilleures performances dans les boucles serrées. Les allocations sont libérées en bloc.

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

## Code unsafe

Le bloc `unsafe` permet des opérations qui contournent les garanties de sécurité de V, telles que l'arithmétique de pointeurs et l'accès direct à la mémoire.

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

### Arithmétique de pointeurs

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

## Optimisation des performances

Choisir le bon mode de gestion de la mémoire peut avoir un impact significatif sur les performances.

### Benchmarker différents modes

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

### Optimiser les structures de données

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

## Résumé

Dans ce chapitre, vous avez appris les modes de gestion de la mémoire, l'allocation pile vs tas, autofree, la gestion manuelle de la mémoire, prealloc, le code unsafe et l'optimisation des performances. Dans le chapitre suivant, nous explorerons l'outillage.
