# Приложение C: Справочник по синтаксису V

## Функции

```v
fn function_name(param1 int, param2 string) int {
    return param1
}
```

## Структуры

```v
struct StructName {
    field1 int
    field2 string
pub:
    public_field int
}
```

## Перечисления

```v
enum EnumName {
    value1
    value2
}
```

## Суммирующие типы

```v
struct Type1 {}
struct Type2 {}

type SumType = Type1 | Type2
```

## Интерфейсы

```v
interface InterfaceName {
    method_name() int
}
```

## Модули

```v ignore
module module_name

pub fn public_function() {
    // ...
}
```
