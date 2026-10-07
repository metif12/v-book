# فصل ۱۱: تست‌نویسی

V یک فریم‌ورک تست داخلی دارد.

## فایل‌های تست

یک فایل با پسوند `_test.v` ایجاد کنید:

```v
fn add(a int, b int) int {
    return a + b
}

fn test_add() {
    assert add(2, 3) == 5
    assert add(-1, 1) == 0
}
```

## اجرای تست‌ها

```bash
v test .
```

## سازماندهی تست‌ها

```v
fn add(a int, b int) int {
    return a + b
}

fn sub(a int, b int) int {
    return a - b
}

fn mul(a int, b int) int {
    return a * b
}

fn test_add() {
    assert add(2, 3) == 5
}

fn test_sub() {
    assert sub(5, 3) == 2
}

fn test_mul() {
    assert mul(2, 3) == 6
}
```

## تست‌های جدول‌محور

```v
fn add(a int, b int) int {
    return a + b
}

fn test_add() {
    tests := [
        [2, 3, 5],
        [-1, 1, 0],
        [0, 0, 0],
    ]
    for t in tests {
        assert add(t[0], t[1]) == t[2]
    }
}
```

## خلاصه

در این فصل، درباره فریم‌ورک تست V یاد گرفتید. در فصل بعد، یک ابزار خط فرمان می‌سازیم.
