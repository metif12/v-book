# الاختبار مع v test

V يحتوي على إطار عمل اختبار مدمج. أنشئ ملفاً ينتهي بـ `_test.v`:

```v
fn add(a int, b int) int {
    return a + b
}

fn test_add() {
    assert add(2, 3) == 5
    assert add(-1, 1) == 0
}
```

شغّل الاختبارات:

```bash
v test .
```

## دوال الاختبار

دوال الاختبار تبدأ بـ `test_` ولا تأخذ معاملات:

```v
fn test_something() {
    assert true
}
```

## التأكيدات

استخدم `assert` للتحقق من الشروط:

```v
fn test_math() {
    assert 1 + 1 == 2
    assert 2 * 3 == 6
}
```

## التالي

[الفصل 3: المفاهيم الشائعة](ch03-common-concepts.md)
