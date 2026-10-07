# Глава 11: Тестирование

В V есть встроенный фреймворк для тестирования.

## Тестовые файлы

Создайте файл с окончанием `_test.v`:

```v
fn add(a int, b int) int {
    return a + b
}

fn test_add() {
    assert add(2, 3) == 5
    assert add(-1, 1) == 0
}
```

## Запуск тестов

```bash
v test .
```

## Организация тестов

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

## Табличные тесты

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

## Итоги

В этой главе вы узнали о фреймворке тестирования V. В следующей главе мы создадим инструмент командной строки.
