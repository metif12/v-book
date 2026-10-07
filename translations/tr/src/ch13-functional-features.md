# Bölüm 13: Fonksiyonel Özellikler

V, closure'ları ve üst düzey fonksiyonları destekler.

## Closure'lar

```v
fn main() {
    add := fn (a int, b int) int {
        return a + b
    }
    println(add(2, 3))
}
```

## Üst düzey fonksiyonlar

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

## Anonim fonksiyonlar

```v
fn main() {
    nums := [1, 2, 3, 4, 5]
    doubled := nums.map(fn (x int) int {
        return x * 2
    })
    println(doubled)
}
```

## Özet

Bu bölümde closure'lar ve üst düzey fonksiyonlar hakkında bilgi edindiniz. Sonraki bölümde eşzamanlılığı inceleyeceğiz.
