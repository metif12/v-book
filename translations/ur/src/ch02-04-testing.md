# v test کے ساتھ ٹیسٹنگ

V میں ایک بلٹ اِن ٹیسٹنگ فریم ورک ہے۔ `_test.v` پر ختم ہونے والی فائل بنائیں:

```v
fn add(a int, b int) int {
    return a + b
}

fn test_add() {
    assert add(2, 3) == 5
    assert add(-1, 1) == 0
}
```

ٹیسٹ چلائیں:

```bash
v test .
```

## ٹیسٹ فنکشنز

ٹیسٹ فنکشنز `test_` سے شروع ہوتے ہیں اور کوئی دلیل نہیں لیتے:

```v
fn test_something() {
    assert true
}
```

## اثبات

شرائط کی جانچ کے لیے `assert` استعمال کریں:

```v
fn test_math() {
    assert 1 + 1 == 2
    assert 2 * 3 == 6
}
```

## اگلا

[باب ۳: عام تصورات](ch03-common-concepts.md)
