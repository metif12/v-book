# Ссылки

Используйте ссылки, чтобы избежать копирования больших объёмов данных:

```v
fn modify(mut arr []int) {
    arr << 42
}

fn main() {
    mut data := [1, 2, 3]
    modify(mut data)
    println(data)
}
```

## Далее

[Глава 5: Структуры](ch05-structs.md)
