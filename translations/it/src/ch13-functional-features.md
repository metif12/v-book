# Capitolo 13: Funzionalità Funzionali

V supporta le closure e le funzioni di ordine superiore.

## Closure

```v
fn main() {
    add := fn (a int, b int) int {
        return a + b
    }
    println(add(2, 3))
}
```

## Funzioni di ordine superiore

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

## Funzioni anonime

```v
fn main() {
    nums := [1, 2, 3, 4, 5]
    doubled := nums.map(fn (x int) int {
        return x * 2
    })
    println(doubled)
}
```

## Riassunto

In questo capitolo, hai imparato le closure e le funzioni di ordine superiore. Nel prossimo capitolo, esploreremo la concorrenza.
