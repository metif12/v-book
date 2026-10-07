# Pruebas con v test

V tiene un framework de pruebas integrado. Crea un archivo que termine en `_test.v`:

```v
fn add(a int, b int) int {
    return a + b
}

fn test_add() {
    assert add(2, 3) == 5
    assert add(-1, 1) == 0
}
```

Ejecuta las pruebas:

```bash
v test .
```

## Funciones de prueba

Las funciones de prueba comienzan con `test_` y no reciben argumentos:

```v
fn test_something() {
    assert true
}
```

## Aserciones

Usa `assert` para verificar condiciones:

```v
fn test_math() {
    assert 1 + 1 == 2
    assert 2 * 3 == 6
}
```

## Siguiente

[Capítulo 3: Conceptos Comunes](ch03-common-concepts.md)
