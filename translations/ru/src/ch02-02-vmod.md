# v.mod

Файл `v.mod` описывает ваш проект:

```v ignore
Module {
    name: 'my_project'
    description: 'My first V project'
    version: '0.1.0'
    license: 'MIT'
    dependencies: []
}
```

## Поля

| Поле | Описание |
|------|----------|
| `name` | Имя проекта (должно совпадать с именем каталога) |
| `description` | Краткое описание |
| `version` | Семантическая версия |
| `license` | Идентификатор лицензии |
| `dependencies` | Список имён пакетов VPM |

## Далее

[Форматирование с помощью v fmt](ch02-03-formatting.md)
