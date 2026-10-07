# Appendice C: Riferimento Sintassi V

## Funzioni

```v
fn function_name(param1 int, param2 string) int {
    return param1
}
```

## Struct

```v
struct StructName {
    field1 int
    field2 string
pub:
    public_field int
}
```

## Enum

```v
enum EnumName {
    value1
    value2
}
```

## Tipi sum

```v
struct Type1 {}
struct Type2 {}

type SumType = Type1 | Type2
```

## Interfacce

```v
interface InterfaceName {
    method_name() int
}
```

## Moduli

```v ignore
module module_name

pub fn public_function() {
    // ...
}
```
