# Bölüm 11: Test Etme

V'nin yerleşik bir test çerçevesi vardır.

## Test dosyaları

`_test.v` ile biten bir dosya oluşturun:

```v
fn add(a int, b int) int {
    return a + b
}

fn test_add() {
    assert add(2, 3) == 5
    assert add(-1, 1) == 0
}
```

## Testleri çalıştırma

```bash
v test .
```

## Test organizasyonu

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

## Tablo odaklı testler

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

## Özet

Bu bölümde V'nin test çerçevesi hakkında bilgi edindiniz. Sonraki bölümde bir komut satırı aracı oluşturacağız.
