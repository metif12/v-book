# Menguji dengan v test

V memiliki framework testing bawaan. Buat file yang diakhiri dengan `_test.v`:

```v
fn add(a int, b int) int {
    return a + b
}

fn test_add() {
    assert add(2, 3) == 5
    assert add(-1, 1) == 0
}
```

Jalankan test:

```bash
v test .
```

## Fungsi test

Fungsi test dimulai dengan `test_` dan tidak mengambil argumen:

```v
fn test_something() {
    assert true
}
```

## Assertion

Gunakan `assert` untuk memeriksa kondisi:

```v
fn test_math() {
    assert 1 + 1 == 2
    assert 2 * 3 == 6
}
```

## Berikutnya

[Bab 3: Konsep Umum](ch03-common-concepts.md)
