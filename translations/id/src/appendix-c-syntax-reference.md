# Lampiran C: Referensi Sintaks V

## Fungsi

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

## Tipe sum

```v
struct Type1 {}
struct Type2 {}

type SumType = Type1 | Type2
```

## Interface

```v
interface InterfaceName {
    method_name() int
}
```

## Modul

```v ignore
module module_name

pub fn public_function() {
    // ...
}
```
