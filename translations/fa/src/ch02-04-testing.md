# تست با v test

V یک فریم‌ورک تست داخلی دارد. یک فایل با پسوند `_test.v` ایجاد کنید:

```v
fn add(a int, b int) int {
    return a + b
}

fn test_add() {
    assert add(2, 3) == 5
    assert add(-1, 1) == 0
}
```

تست‌ها را اجرا کنید:

```bash
v test .
```

## توابع تست

توابع تست با `test_` شروع می‌شوند و هیچ آرگومانی نمی‌گیرند:

```v
fn test_something() {
    assert true
}
```

## تأییدیه‌ها

از `assert` برای بررسی شرایط استفاده کنید:

```v
fn test_math() {
    assert 1 + 1 == 2
    assert 2 * 3 == 6
}
```

## بعدی

[فصل ۳: مفاهیم رایج](ch03-common-concepts.md)
