# Kapitel 18: Speichermanagement vertiefen

## GC-Modi

V bietet mehrere Speicherverwaltungsstrategien, die jeweils für verschiedene Anwendungsfälle geeignet sind.

| Modus | Flag | Anwendungsfall |
|------|------|----------|
| Boehm GC | `-gc boehm` | Allgemeiner Zweck |
| Autofree | `-autofree` | Automatische Freigabe |
| Keiner | `-gc none` | Manuelle Verwaltung |
| Prealloc | `-prealloc` | Arena-Allokation |

## Stack vs Heap

V entscheidet automatisch, wo Speicher allokiert wird. Kleine, kurzlebige Werte bleiben auf dem Stack. Größere oder entkommende Werte wandern auf den Heap.

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

## Autofree-Modus

Autofree gibt Speicher automatisch frei, wenn Variablen ihren Gültigkeitsbereich verlassen. Es verwendet Referenzzählung für Heap-Allokationen.

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

## -gc none und manueller Speicher

Mit `-gc none` deaktiviert V die Garbage Collection. Sie müssen den Speicher manuell mit `free` verwalten.

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

## -prealloc Arena-Allokation

Prealloc verwendet Arena-Allokation für bessere Leistung in engen Schleifen. Allokationen werden in der Masse freigegeben.

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

## Unsicherer Code

Der `unsafe`-Block ermöglicht Operationen, die V-Sicherheitsgeharantien umgehen, wie Zeigerarithmetik und direkter Speicherzugriff.

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

### Zeigerarithmetik

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

## Leistungsoptimierung

Die Wahl des richtigen Speicherverwaltungsmodus kann die Leistung erheblich beeinflussen.

### Benchmarking verschiedener Modi

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

### Datenstrukturen optimieren

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

## Zusammenfassung

In diesem Kapitel haben Sie Speicherverwaltungsmodi, Stack-vs-Heap-Allokation, Autofree, manuelle Speicherverwaltung, Prealloc, unsicheren Code und Leistungsoptimierung kennengelernt. Im nächsten Kapitel untersuchen wir Tooling.
