# الفصل 11: الاختبار

V لديه إطار عمل اختبار مدمج.

## ملفات الاختبار

أنشئ ملفاً ينتهي بـ `_test.v`:

```v
fn add(a int, b int) int {
    return a + b
}

fn test_add() {
    assert add(2, 3) == 5
    assert add(-1, 1) == 0
}
```

## تشغيل الاختبارات

```bash
v test .
```

## تنظيم الاختبارات

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

## اختبارات قائمة على الجداول

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

## الملخص

في هذا الفصل، تعلمت عن إطار عمل الاختبار في V. في الفصل التالي، سنبني أداة سطر أوامر.
