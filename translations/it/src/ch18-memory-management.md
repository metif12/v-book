# Capitolo 18: Approfondimento sulla Gestione della Memoria

## Modalità GC

V fornisce diverse strategie di gestione della memoria, ognuna adatta a diversi casi d'uso.

| Modalità | Flag | Caso d'uso |
|----------|------|------------|
| Boehm GC | `-gc boehm` | Uso generale |
| Autofree | `-autofree` | Liberazione automatica |
| Nessuna | `-gc none` | Gestione manuale |
| Prealloc | `-prealloc` | Allocazione arena |

## Stack vs heap

V decide automaticamente dove allocare la memoria. I valori piccoli e di breve durata restano sullo stack. I valori più grandi o che "escapano" vanno sull'heap.

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

## Modalità autofree

Autofree libera automaticamente la memoria quando le variabili escono dallo scope. Usa il reference counting per le allocazioni heap.

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

## -gc none e memoria manuale

Con `-gc none`, V disabilita la garbage collection. Devi gestire manualmente la memoria usando `free`.

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

## Allocazione arena con -prealloc

Prealloc usa l'allocazione arena per migliori prestazioni in loop serrati. Le allocazioni vengono liberate in blocco.

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

## Codice unsafe

Il blocco `unsafe` permette operazioni che aggirano le garanzie di sicurezza di V, come l'aritmetica dei puntatori e l'accesso diretto alla memoria.

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

### Aritmetica dei puntatori

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

## Ottimizzazione delle prestazioni

Scegliere la modalità di gestione della memoria giusta può impattare significativamente le prestazioni.

### Benchmark delle diverse modalità

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

### Ottimizzazione delle strutture dati

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

## Riassunto

In questo capitolo, hai imparato le modalità di gestione della memoria, l'allocazione stack vs heap, autofree, la gestione manuale della memoria, prealloc, il codice unsafe e l'ottimizzazione delle prestazioni. Nel prossimo capitolo, esploreremo il tooling.
