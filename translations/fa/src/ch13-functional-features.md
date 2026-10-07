# فصل ۱۳: ویژگی‌های تابعی

V از بسته‌ها (closures) و توابع مرتبه بالا پشتیبانی می‌کند.

## بسته‌ها

```v
fn main() {
    add := fn (a int, b int) int {
        return a + b
    }
    println(add(2, 3))
}
```

## توابع مرتبه بالا

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

## توابع ناشناس

```v
fn main() {
    nums := [1, 2, 3, 4, 5]
    doubled := nums.map(fn (x int) int {
        return x * 2
    })
    println(doubled)
}
```

## خلاصه

در این فصل، درباره بسته‌ها و توابع مرتبه بالا یاد گرفتید. در فصل بعد، به همزمانی می‌پردازیم.
