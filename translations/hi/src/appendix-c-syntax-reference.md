# अपेंडिक्स C: V सिंटैक्स रेफरेंस

## फ़ंक्शन

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

## Sum types

```v
struct Type1 {}
struct Type2 {}

type SumType = Type1 | Type2
```

## इंटरफ़ेस

```v
interface InterfaceName {
    method_name() int
}
```

## मॉड्यूल

```v ignore
module module_name

pub fn public_function() {
    // ...
}
```
