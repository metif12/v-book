# Testing con v test

V ha un framework di testing integrato. Crea un file che termina con `_test.v`:

```v
fn add(a int, b int) int {
    return a + b
}

fn test_add() {
    assert add(2, 3) == 5
    assert add(-1, 1) == 0
}
```

Esegui i test:

```bash
v test .
```

## Funzioni di test

Le funzioni di test iniziano con `test_` e non accettano argomenti:

```v
fn test_something() {
    assert true
}
```

## Asserzioni

Usa `assert` per verificare condizioni:

```v
fn test_math() {
    assert 1 + 1 == 2
    assert 2 * 3 == 6
}
```

## Avanti

[Capitolo 3: Concetti Comuni](ch03-common-concepts.md)
