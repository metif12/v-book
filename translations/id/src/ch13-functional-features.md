# Bab 13: Fitur Fungsional

V mendukung closure dan higher-order function.

## Closure

```v
fn main() {
    add := fn (a int, b int) int {
        return a + b
    }
    println(add(2, 3))
}
```

## Higher-order function

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

## Fungsi anonim

```v
fn main() {
    nums := [1, 2, 3, 4, 5]
    doubled := nums.map(fn (x int) int {
        return x * 2
    })
    println(doubled)
}
```

## Ringkasan

Dalam bab ini, Anda telah belajar tentang closure dan higher-order function. Di bab berikutnya, kita akan menjelajahi konkurensi.
