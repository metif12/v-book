# Kapitel 13: Funktionale Merkmale

V unterstützt Closures und Funktionen höherer Ordnung.

## Closures

```v
fn main() {
    add := fn (a int, b int) int {
        return a + b
    }
    println(add(2, 3))
}
```

## Funktionen höherer Ordnung

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

## Anonyme Funktionen

```v
fn main() {
    nums := [1, 2, 3, 4, 5]
    doubled := nums.map(fn (x int) int {
        return x * 2
    })
    println(doubled)
}
```

## Zusammenfassung

In diesem Kapitel haben Sie Closures und Funktionen höherer Ordnung kennengelernt. Im nächsten Kapitel untersuchen wir Nebenläufigkeit.
