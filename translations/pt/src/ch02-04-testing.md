# Testes com v test

V tem um framework de testes imbutido. Crie um arquivo terminando em `_test.v`:

```v
fn add(a int, b int) int {
    return a + b
}

fn test_add() {
    assert add(2, 3) == 5
    assert add(-1, 1) == 0
}
```

Execute os testes:

```bash
v test .
```

## Funções de teste

Funções de teste começam com `test_` e não recebem argumentos:

```v
fn test_something() {
    assert true
}
```

## Asserções

Use `assert` para verificar condições:

```v
fn test_math() {
    assert 1 + 1 == 2
    assert 2 * 3 == 6
}
```

## Próximo

[Capítulo 3: Conceitos Comuns](ch03-common-concepts.md)
