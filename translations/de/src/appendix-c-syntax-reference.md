# Anhang C: V-Syntaxreferenz

## Funktionen

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

## Sum Types

```v
struct Type1 {}
struct Type2 {}

type SumType = Type1 | Type2
```

## Schnittstellen

```v
interface InterfaceName {
    method_name() int
}
```

## Module

```v ignore
module module_name

pub fn public_function() {
    // ...
}
```
