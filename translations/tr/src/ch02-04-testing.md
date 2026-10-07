# v test ile Test Etme

V'nin yerleşik bir test çerçevesi vardır. `_test.v` ile biten bir dosya oluşturun:

```v
fn add(a int, b int) int {
    return a + b
}

fn test_add() {
    assert add(2, 3) == 5
    assert add(-1, 1) == 0
}
```

Testleri çalıştırın:

```bash
v test .
```

## Test fonksiyonları

Test fonksiyonları `test_` ile başlar ve argüman almaz:

```v
fn test_something() {
    assert true
}
```

## Assert ifadeleri

Koşulları kontrol etmek için `assert` kullanın:

```v
fn test_math() {
    assert 1 + 1 == 2
    assert 2 * 3 == 6
}
```

## Sonraki

[Bölüm 3: Ortak Kavramlar](ch03-common-concepts.md)
