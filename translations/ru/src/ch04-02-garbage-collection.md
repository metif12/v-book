# Сборщик мусора

V по умолчанию использует сборщик мусора:

```v
fn main() {
    mut names := []string{}
    for i in 0 .. 100 {
        names << 'name ${i}'
    }
    // Memory is automatically freed when no longer referenced
    println(names.len)
}
```

## Отключение сборщика мусора

Для критичного к производительности кода вы можете отключить сборщик мусора:

```bash
v -gc none main.v
```

## Далее

[Автоосвобождение](ch04-03-autofree.md)
