# Тестирование с помощью v test

В V есть встроенный фреймворк для тестирования. Создайте файл с окончанием `_test.v`:

```v
fn add(a int, b int) int {
    return a + b
}

fn test_add() {
    assert add(2, 3) == 5
    assert add(-1, 1) == 0
}
```

Запустите тесты:

```bash
v test .
```

## Тестовые функции

Тестовые функции начинаются с `test_` и не принимают аргументов:

```v
fn test_something() {
    assert true
}
```

## Проверки (asserts)

Используйте `assert` для проверки условий:

```v
fn test_math() {
    assert 1 + 1 == 2
    assert 2 * 3 == 6
}
```

## Далее

[Глава 3: Общие концепции](ch03-common-concepts.md)
