# الفصل 13: الميزات الوظيفية

V يدعم الإغلاقات (closures) والدوال من الرتبة العليا (higher-order functions).

## الإغلاقات (Closures)

```v
fn main() {
    add := fn (a int, b int) int {
        return a + b
    }
    println(add(2, 3))
}
```

## الدوال من الرتبة العليا

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

## الدوال المجهولة

```v
fn main() {
    nums := [1, 2, 3, 4, 5]
    doubled := nums.map(fn (x int) int {
        return x * 2
    })
    println(doubled)
}
```

## الملخص

في هذا الفصل، تعلمت عن الإغلاقات والدوال من الرتبة العليا. في الفصل التالي، سنستكشف التزامن.
