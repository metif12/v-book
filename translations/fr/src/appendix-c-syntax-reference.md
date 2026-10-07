# Appendix C: V Syntax Reference

## Functions

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

## Interfaces

```v
interface InterfaceName {
    method_name() int
}
```

## Modules

```v ignore
module module_name

pub fn public_function() {
    // ...
}
```
