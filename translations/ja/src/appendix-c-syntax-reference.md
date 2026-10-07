# 付録C：V構文リファレンス

## 関数

```v
fn function_name(param1 int, param2 string) int {
    return param1
}
```

## struct

```v
struct StructName {
    field1 int
    field2 string
pub:
    public_field int
}
```

## enum

```v
enum EnumName {
    value1
    value2
}
```

## sum型

```v
struct Type1 {}
struct Type2 {}

type SumType = Type1 | Type2
```

## インターフェース

```v
interface InterfaceName {
    method_name() int
}
```

## モジュール

```v ignore
module module_name

pub fn public_function() {
    // ...
}
```
