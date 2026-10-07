# الملحق C: مرجع بناء جملة V

## الدوال

```v
fn function_name(param1 int, param2 string) int {
    return param1
}
```

## Structs

```v
struct StructName {
    field1 int
    field2 string
pub:
    public_field int
}
```

## Enums

```v
enum EnumName {
    value1
    value2
}
```

## أنواع الجمع

```v
struct Type1 {}
struct Type2 {}

type SumType = Type1 | Type2
```

## Interfaces

```v
interface InterfaceName {
    method_name() int
}
```

## الوحدات

```v ignore
module module_name

pub fn public_function() {
    // ...
}
```
