# باب ۱۱: ٹیسٹنگ

V میں ایک بلٹ اِن ٹیسٹنگ فریم ورک ہے۔

## ٹیسٹ فائلیں

`_test.v` پر ختم ہونے والی فائل بنائیں:

```v
fn add(a int, b int) int {
    return a + b
}

fn test_add() {
    assert add(2, 3) == 5
    assert add(-1, 1) == 0
}
```

## ٹیسٹ چلانا

```bash
v test .
```

## ٹیسٹ کی تنظیم

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

## ٹیبل ڈرائیون ٹیسٹ

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

## خلاصہ

اس باب میں، آپ نے V کے ٹیسٹنگ فریم ورک کے بارے میں سیکھا۔ اگلے باب میں، ہم ایک کمانڈ لائن ٹول بنائیں گے۔
