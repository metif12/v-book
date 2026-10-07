# Testen mit v test

V verfügt über ein integriertes Testframework. Erstellen Sie eine Datei, die mit `_test.v` endet:

```v
fn add(a int, b int) int {
    return a + b
}

fn test_add() {
    assert add(2, 3) == 5
    assert add(-1, 1) == 0
}
```

Tests ausführen:

```bash
v test .
```

## Testfunktionen

Testfunktionen beginnen mit `test_` und nehmen keine Argumente entgegen:

```v
fn test_something() {
    assert true
}
```

## Assertions

Verwenden Sie `assert`, um Bedingungen zu prüfen:

```v
fn test_math() {
    assert 1 + 1 == 2
    assert 2 * 3 == 6
}
```

## Weiter

[Kapitel 3: Häufige Konzepte](ch03-common-concepts.md)
