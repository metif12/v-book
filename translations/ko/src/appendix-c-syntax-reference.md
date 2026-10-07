# 부록 C: V 문법 레퍼런스

## 함수

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

## Sum type

```v
struct Type1 {}
struct Type2 {}

type SumType = Type1 | Type2
```

## 인터페이스

```v
interface InterfaceName {
    method_name() int
}
```

## 모듈

```v ignore
module module_name

pub fn public_function() {
    // ...
}
```
