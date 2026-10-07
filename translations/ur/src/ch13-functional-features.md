# باب ۱۳: فنکشنل خصوصیات

V کلوزرز اور ہائر آرڈر فنکشنز کی حمایت کرتا ہے۔

## کلوزرز

```v
fn main() {
    add := fn (a int, b int) int {
        return a + b
    }
    println(add(2, 3))
}
```

## ہائر آرڈر فنکشنز

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

## گمنام فنکشنز

```v
fn main() {
    nums := [1, 2, 3, 4, 5]
    doubled := nums.map(fn (x int) int {
        return x * 2
    })
    println(doubled)
}
```

## خلاصہ

اس باب میں، آپ نے کلوزرز اور ہائر آرڈر فنکشنز کے بارے میں سیکھا۔ اگلے باب میں، ہم ہم آہنگی کو دریافت کریں گے۔
